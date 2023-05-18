//
//  WorkoutCoordinator.swift
//  GymIF
//
//  Created by Ian Fagundes on 17/05/23.
//

import Foundation
import UIKit

protocol WorkoutCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeAction, workout: Workout)
}

class WorkoutCoordinator: WorkoutCoordinating {
    weak var viewController: UIViewController?

    private weak var appRouter: AppRouterContract?

    init(appRouter: AppRouterContract?) {
        self.appRouter = appRouter
    }
    
    func perform(action: HomeAction, workout: Workout) {
        switch action {
        case .openExercises:
            appRouter?.send(action: .openWorkout, obj: workout)
        }
    }
}

