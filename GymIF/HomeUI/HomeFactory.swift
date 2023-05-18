//
//  HomeFactory.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import UIKit

public enum HomeFactory {
    public static func make(appRouter: AppRouterContract) -> HomeViewController {
        let coordinator: HomeCoordinating = HomeCoordinator(appRouter: appRouter)
        let viewModel = HomeViewModel(coordinator: coordinator, appRouter: appRouter)
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        coordinator.viewController = viewController

        return viewController
    }
}

