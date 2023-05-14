//
//  AppRouterContract.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import UIKit

public enum AppAction {
    case openLogin
    case openHome
    case openWorkout
}

public protocol AppRouterContract: AnyObject {
    func send(action: AppAction, from viewController: UIViewController?)
}

