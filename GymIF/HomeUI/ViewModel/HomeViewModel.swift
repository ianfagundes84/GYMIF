//
//  HomeViewModel.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation

protocol HomeViewModelContract: AnyObject {}

final class HomeViewModel: HomeViewModelContract {
    // MARK: - Properties
    private let coordinator: HomeCoordinating
    weak var appRouter: AppRouterContract?
    weak var viewController: HomeViewController?
    
    //MARK: - Initializers
    init(coordinator: HomeCoordinating, appRouter: AppRouterContract) {
        self.coordinator = coordinator
        self.appRouter = appRouter
    }
    
    // MARK: - Methods
}
