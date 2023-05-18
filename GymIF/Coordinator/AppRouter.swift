//
//  AppRouter.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

final class AppRouter: AppRouterContract {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func send(action: AppAction, obj: Workout? = nil) {
        switch action {
        case .openLogin:
            openLogin()
        case .openHome:
            openHome()
        case .openWorkout:
            break
        case .presentWorkoutForm(let delegate):
            presentPopOver(delegate: delegate, obj: obj)
        }
    }
    
    private func openLogin() {
        let controller = LoginFactory.make(appRouter: self)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func openHome() {
        let controller = HomeFactory.make(appRouter: self)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func presentPopOver(delegate: WorkoutViewModelDelegate, obj: Workout?) {
        let controller = WorkoutFactory.make(appRouter: self, delegate: delegate, workout: obj)
        controller.modalPresentationStyle = .popover
        navigationController?.present(controller, animated: true, completion: nil)
    }
}


