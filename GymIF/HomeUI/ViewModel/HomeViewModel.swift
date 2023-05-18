//
//  HomeViewModel.swift
//  GymIF
//
//  Created by Ian Fagundes on 14/05/23.
//

import Foundation
import CoreData

protocol HomeViewModelContract: AnyObject {}

final class HomeViewModel: HomeViewModelContract {
    // MARK: - Properties
    
    private let coordinator: HomeCoordinating
    weak var appRouter: AppRouterContract?
    weak var viewController: HomeViewController?
    
    var workouts: [NSManagedObject] = []
    
    //MARK: - Initializers
    init(coordinator: HomeCoordinating, appRouter: AppRouterContract, workoutViewModel: WorkoutViewModel) {
        self.coordinator = coordinator
        self.appRouter = appRouter
    }
    
    // MARK: - Methods
    
}
