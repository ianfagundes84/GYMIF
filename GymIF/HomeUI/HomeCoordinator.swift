//
//  HomeCoordinator.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

public enum HomeAction {
    case openExercises
}

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeAction, workout: Workout?)
}

final class HomeCoordinator {
    weak var viewController: UIViewController?
    private let appRouter: AppRouterContract?
    
    init(appRouter: AppRouterContract? = nil) {
        self.appRouter = appRouter
    }
}

extension HomeCoordinator: HomeCoordinating {
    func perform(action: HomeAction, workout: Workout?) {
        switch action {
        case .openExercises:
            appRouter?.send(action: .openWorkout, obj: workout)
        }
    }
}
