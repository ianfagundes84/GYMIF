//
//  WorkoutFactory.swift
//  GymIF
//
//  Created by Ian Fagundes on 17/05/23.
//

import Foundation
import UIKit

public enum WorkoutFactory {
    public static func make(appRouter: AppRouterContract, delegate: WorkoutViewModelDelegate) -> UIViewController {
        let coordinator = WorkoutCoordinator(appRouter: appRouter)
        let viewModel = WorkoutViewModel(coordinator: coordinator)
        viewModel.delegate = delegate
        let form = WorkoutForm.create(with: viewModel)
        let viewController = UIViewController()
        viewController.view = form
        coordinator.viewController = viewController

        return viewController
    }
}

