//
//  CoreDataManager.swift
//  GymIF
//
//  Created by Ian Fagundes on 18/05/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "GymIF")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    // MARK: - CRUD Operations

    func create<T: NSManagedObject>(_ type: T.Type) -> T {
        return T(context: context)
    }

    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        do {
            return try context.fetch(request)
        } catch let error {
            print("Failed to fetch objects of type \(T.self): ", error)
            return []
        }
    }

    func delete<T: NSManagedObject>(_ object: T) {
        context.delete(object)
    }

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

extension CoreDataManager {
    
    func getOrCreateWorkout(from firestoreWorkout: FirestoreWorkout) -> Workout? {
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", firestoreWorkout.id ?? "")
        
        do {
            let fetchedWorkouts = try context.fetch(fetchRequest)
            if let existingWorkout = fetchedWorkouts.first {
                // Found an existing workout, return it
                return existingWorkout
            } else {
                // No existing workout found, create a new one
                let newWorkout = Workout(context: context)
                newWorkout.id = firestoreWorkout.id
                newWorkout.workoutName = firestoreWorkout.name
                newWorkout.workoutDescription = firestoreWorkout.description
                newWorkout.workoutDate = firestoreWorkout.date
                saveContext()
                return newWorkout
            }
        } catch let error as NSError {
            // handle error
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
}
