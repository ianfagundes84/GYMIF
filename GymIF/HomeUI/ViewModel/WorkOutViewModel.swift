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
    
    var workouts: [Workout] = []
    
    private let coordinator: WorkoutCoordinating
    
    init(coordinator: WorkoutCoordinating) {
        self.coordinator = coordinator
    }
}

extension WorkoutViewModel {
    func createWorkout(name: String, description: String, date: Date) -> Workout {
        let workout: Workout = CoreDataManager.shared.create(Workout.self)
        workout.workoutName = name
        workout.workoutDescription = description
        workout.workoutDate = date
        CoreDataManager.shared.saveContext()
        return workout
    }

    func fetchWorkouts() -> [Workout] {
        return CoreDataManager.shared.fetch(Workout.self)
    }

    func updateWorkout(workout: Workout, name: String, description: String, date: Date) {
        workout.workoutName = name
        workout.workoutDescription = description
        workout.workoutDate = date
        CoreDataManager.shared.saveContext()
    }

    func deleteWorkout(workout: Workout) {
        CoreDataManager.shared.delete(workout)
        CoreDataManager.shared.saveContext()
    }
}
