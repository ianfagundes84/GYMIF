//
//  HomeViewController.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

public class HomeViewController: UIViewController {
    
    private lazy var lbTeste: UILabel = {
        let lb = UILabel()
        return lb
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
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Hierarchy
    private func setupHierarchy() {
        view.addSubview(lbTeste)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        view.backgroundColor = .white
        
        // logo constraints
        lbTeste.centerInSuperview()
    }
}
