//
//  HomeFactory.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import UIKit

public enum HomeFactory {
    public static func make(appRouter: AppRouterContract) -> HomeViewController {
        let homeCoordinator: HomeCoordinating = HomeCoordinator(appRouter: appRouter)
        
        let workoutCoordinator: WorkoutCoordinating = WorkoutCoordinator(appRouter: appRouter)
        let workoutViewModel = WorkoutViewModel(coordinator: workoutCoordinator)
        let homeViewModel = HomeViewModel(coordinator: homeCoordinator, appRouter: appRouter, workoutViewModel: workoutViewModel)
        
        let viewController = HomeViewController(viewModel: homeViewModel, workoutViewModel: workoutViewModel)
        homeViewModel.viewController = viewController
        homeCoordinator.viewController = viewController

        return viewController
    }
}


