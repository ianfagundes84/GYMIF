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
    case presentWorkoutForm(delegate: WorkoutViewModelDelegate)
}

public protocol AppRouterContract: AnyObject {
    func send(action: AppAction)
    func presentPopOver(delegate: WorkoutViewModelDelegate)
}


