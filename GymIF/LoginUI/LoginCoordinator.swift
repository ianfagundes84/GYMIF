//
//  LoginCoordinator.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

public enum LoginAction {
    case openHome
}

protocol LoginCoordinating: AnyObject {
    func perform(action: LoginAction)
}

final class LoginCoordinator {
    private let appRouter: AppRouterContract?

    init(appRouter: AppRouterContract? = nil) {
        self.appRouter = appRouter
    }
}

extension LoginCoordinator: LoginCoordinating {
    func perform(action: LoginAction) {
        switch action {
        case .openHome:
            appRouter?.send(action: .openHome, obj: nil)
        }
    }
}
