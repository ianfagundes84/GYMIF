//
//  WorkOutViewModel.swift
//  GymIF
//
//  Created by Ian Fagundes on 17/05/23.
//

import Foundation
import UIKit
import CoreData

public protocol WorkoutViewModelDelegate: AnyObject {
    func didUpdateWorkout()
    func dismissWorkoutForm()
}

class WorkoutViewModel {
    weak var delegate: WorkoutViewModelDelegate?
    
    let workoutManager = FirestoreWorkoutManager.shared
    
    var workouts: [Workout] = []
    
    private let coordinator: WorkoutCoordinating
    
    init(coordinator: WorkoutCoordinating) {
        self.coordinator = coordinator
    }
}

extension WorkoutViewModel {
    func createWorkout(name: String, description: String, date: Date, completion: @escaping (Result<Workout, Error>) -> Void) {
        workoutManager.createWorkout(name: name, description: description, date: date, completion: completion)
    }
    
    func fetchWorkouts() -> [Workout] {
        return CoreDataManager.shared.fetch(Workout.self)
    }
    
    func updateWorkout(workout: Workout, completion: @escaping (Result<Workout, Error>) -> Void) {
        workoutManager.updateWorkout(workout: workout, completion: completion)
    }
    
    func deleteWorkout(workout: Workout, completion: @escaping (Result<Void, Error>) -> Void) {
        workoutManager.deleteWorkout(workout: workout, completion: completion)
    }
}
