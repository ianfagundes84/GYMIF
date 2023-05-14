//
//  AppRouter.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

final class AppRouter: AppRouterContract {
    
    static let shared = AppRouter()
    
    func send(action: AppAction, from viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        switch action {
        case .openHome:
            openHome(viewController)
        case .openLogin:
            openLogin(viewController)
        case .openWorkout:
            break
        }
    }
    
    private func openLogin(_ viewController: UIViewController) {
        let controller = LoginFactory.make(appRouter: self)
        let navigationController = viewController as? UINavigationController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func openHome(_ viewController: UIViewController) {
        let controller = HomeFactory.make(appRouter: self)
        let navigationController = viewController as? UINavigationController
        navigationController?.pushViewController(controller, animated: true)
    }
} 
