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
    
    private var viewModel: HomeViewModel
    
    // MARK: - Initializer
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func addWorkout() {
        viewModel.appRouter?.send(action: .presentWorkoutForm(delegate: self))
    }
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewController = self
        buildViewHierarchy()
        setupConstraints()
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
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkOutTableViewCell.identifier, for: indexPath)
        // TODO: - cell.configure, cell.delegate = self
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: WorkoutViewModelDelegate {
    public func didUpdateWorkout() {
        
    }
    
    public func dismissWorkoutForm() {
        dismiss(animated: true)
    }
    
}
