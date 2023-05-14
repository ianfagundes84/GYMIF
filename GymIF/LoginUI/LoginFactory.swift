//
//  LoginFactory.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

public enum LoginFactory {
    public static func make(appRouter: AppRouterContract) -> LoginViewController {
        let coordinator: LoginCoordinating = LoginCoordinator(appRouter: appRouter)
        let viewModel = LoginViewModel(coordinator: coordinator)
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        return viewController
    }
}
