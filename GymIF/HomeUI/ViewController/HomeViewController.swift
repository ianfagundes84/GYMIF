//
//  HomeViewController.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit
import TinyConstraints

public class HomeViewController: UIViewController {
    //MARK: - Properties
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor.systemBackground
        tv.estimatedRowHeight = 100
        tv.register(WorkOutTableViewCell.self, forCellReuseIdentifier: WorkOutTableViewCell.identifier)
        return tv
    }()
    
    lazy var addWorkoutButton: AddButton = {
        let bt = AddButton()
        bt.onTouchUpInside = { [weak self] in
            self?.addWorkout()
        }
        return bt
    }()
    
    private var workoutForm: WorkoutForm?
    private var homeViewModel: HomeViewModel
    private var workoutViewModel: WorkoutViewModel
    
    // MARK: - Initializer
    init(viewModel: HomeViewModel, workoutViewModel: WorkoutViewModel) {
        self.homeViewModel = viewModel
        self.workoutViewModel = workoutViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func addWorkout() {
        homeViewModel.appRouter?.send(action: .presentWorkoutForm(delegate: self), obj: nil)
    }
    
    private func fetchWorkouts() {
        self.homeViewModel.workouts = workoutViewModel.fetchWorkouts()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel.viewController = self
        buildViewHierarchy()
        setupConstraints()
        fetchWorkouts()
    }
    
    // MARK: - Hierarchy
    private func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(addWorkoutButton)
    }
    
    // MARK: - Layout
    private func setupConstraints() {
        tableView.topToSuperview(offset: 160)
        tableView.bottomToSuperview(offset: -80)
        tableView.leadingToSuperview(offset: 16)
        tableView.trailingToSuperview(offset: 16)
        
        addWorkoutButton.trailingToSuperview(offset: 36)
        addWorkoutButton.bottomToSuperview(offset: -60)
        addWorkoutButton.width(50)
        addWorkoutButton.height(50)
        
        view.backgroundColor = .white
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.workouts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkOutTableViewCell.identifier, for: indexPath) as! WorkOutTableViewCell
        guard let workout = homeViewModel.workouts[indexPath.row] as? Workout else { return UITableViewCell() }
        cell.configure(workout: workout)
        
        cell.onLongPress = { [weak self, weak tableView] in
            guard let self = self, let tableView = tableView else { return }
            DispatchQueue.main.async { 
                if let index = self.homeViewModel.workouts.firstIndex(of: workout) {
                    self.workoutViewModel.deleteWorkout(workout: workout) { _ in
                        self.homeViewModel.workouts.remove(at: index)
                        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    }
                }
            }
        }
        cell.onEdit = { [weak self] in
            self?.editWorkout(workout)
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: WorkoutViewModelDelegate {    
    public func didUpdateWorkout() {
        fetchWorkouts()
    }
    
    public func dismissWorkoutForm() {
        dismiss(animated: true)
        fetchWorkouts()
    }
    
    public func editWorkout(_ workout: Workout) {
        homeViewModel.appRouter?.send(action: .presentWorkoutForm(delegate: self), obj: workout)
    }
}
