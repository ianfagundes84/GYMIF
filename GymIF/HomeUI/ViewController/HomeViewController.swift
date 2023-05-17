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
    
    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewController = self
        buildViewHierarchy()
        setupConstraints()
    }
    
    // MARK: - Hierarchy
    private func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    // MARK: - Layout
    private func setupConstraints() {
        tableView.topToSuperview(offset: 160)
        tableView.bottomToSuperview(offset: -80)
        tableView.leadingToSuperview(offset: 16)
        tableView.trailingToSuperview(offset: 16)
        
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

extension HomeViewController: UITableViewDelegate {
    
}
