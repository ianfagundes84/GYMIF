//
//  WorkOutViewModel.swift
//  GymIF
//
//  Created by Ian Fagundes on 17/05/23.
//

import Foundation

public protocol WorkoutViewModelDelegate: AnyObject {
    func didUpdateWorkout()
    func dismissWorkoutForm()
}

class WorkoutViewModel {
    weak var delegate: WorkoutViewModelDelegate?
    
    private var workout: Workout? {
        didSet {
            delegate?.didUpdateWorkout()
        }
    }
    
    private let coordinator: WorkoutCoordinating

    init(coordinator: WorkoutCoordinating) {
        self.coordinator = coordinator
    }

    func loadWorkout(withId id: String) {
    }

    func getWorkoutName() -> String {
        return ""
    }
}
