//
//  AppRouter.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

import Foundation
import UIKit

final class AppRouter: AppRouterContract {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func send(action: AppAction) {
        switch action {
        case .openLogin:
            openLogin()
        case .openHome:
            openHome()
        case .openWorkout:
            break
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
}

