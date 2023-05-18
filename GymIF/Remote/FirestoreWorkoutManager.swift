//
//  FirestoreWorkoutManager.swift
//  GymIF
//
//  Created by Ian Fagundes on 18/05/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import CoreData

class FirestoreWorkoutManager {
    static let shared = FirestoreWorkoutManager()
    
    private init() {}
    
    let db = Firestore.firestore()
    
    // MARK: - Create
    func createWorkout(name: String, description: String, date: Date, completion: @escaping (Result<Workout, Error>) -> Void) {
        let firestoreWorkout = FirestoreWorkout(name: name, description: description, date: date)
        createFirestoreWorkout(workout: firestoreWorkout) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                let coreDataWorkout = self.createCoreDataWorkout(from: firestoreWorkout)
                completion(.success(coreDataWorkout))
            }
        }
    }
    
    private func createFirestoreWorkout(workout: FirestoreWorkout, completion: @escaping (Error?) -> Void) {
        var ref: DocumentReference? = nil
        ref = db.collection("workouts").addDocument(data: workout.dictionary) { error in
            if let error = error {
                print("Error adding document: \(error)")
                completion(error)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                workout.id = ref?.documentID
                completion(nil)
            }
        }
    }
    
    private func createCoreDataWorkout(from firestoreWorkout: FirestoreWorkout) -> Workout {
        let coreDataWorkout: Workout = CoreDataManager.shared.create(Workout.self)
        coreDataWorkout.id = firestoreWorkout.id
        coreDataWorkout.workoutName = firestoreWorkout.name
        coreDataWorkout.workoutDescription = firestoreWorkout.description
        coreDataWorkout.workoutDate = firestoreWorkout.date
        CoreDataManager.shared.saveContext()
        return coreDataWorkout
    }
    
    // MARK: - Fetch
    func fetchWorkouts(completion: @escaping (Result<[Workout], Error>) -> Void) {
        fetchFirestoreWorkouts { (firestoreWorkouts, error) in
            if let error = error {
                completion(.failure(error))
            } else if let firestoreWorkouts = firestoreWorkouts {
                var coreDataWorkouts = [Workout]()
                for firestoreWorkout in firestoreWorkouts {
                    if let coreDataWorkout: Workout = CoreDataManager.shared.getOrCreateWorkout(from: firestoreWorkout) {
                        coreDataWorkouts.append(coreDataWorkout)
                    }
                }
                completion(.success(coreDataWorkouts))
            }
        }
    }
    
    private func fetchFirestoreWorkouts(completion: @escaping ([FirestoreWorkout]?, Error?) -> Void) {
        db.collection("workouts").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else if let documents = querySnapshot?.documents {
                var workouts = [FirestoreWorkout]()
                for document in documents {
                    let result = Result {
                        try document.data()
                    }
                    switch result {
                    case .success(let data):
                        if let workout = FirestoreWorkout(dictionary: data) {
                            workout.id = document.documentID
                            workouts.append(workout)
                        }
                    case .failure(let error):
                        print("Error decoding workout: \(error)")
                    }
                }
                completion(workouts, nil)
            }
        }
    }

    
    // MARK: - Update
    func updateWorkout(workout: Workout, completion: @escaping (Result<Workout, Error>) -> Void) {
        guard let firestoreWorkout = FirestoreWorkout(from: workout) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Failed to convert Workout to FirestoreWorkout"])))
            return
        }
        updateFirestoreWorkout(workout: firestoreWorkout) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                let updatedCoreDataWorkout = self.updateCoreDataWorkout(with: workout, from: firestoreWorkout)
                completion(.success(updatedCoreDataWorkout))
            }
        }
    }
    
    private func updateFirestoreWorkout(workout: FirestoreWorkout, completion: @escaping (Error?) -> Void) {
        if let workoutId = workout.id {
            db.collection("workouts").document(workoutId).setData(workout.dictionary) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                    completion(error)
                } else {
                    print("Document successfully updated")
                    completion(nil)
                }
            }
        }
    }
    
    private func updateCoreDataWorkout(with workout: Workout, from firestoreWorkout: FirestoreWorkout) -> Workout {
        let coreDataWorkout: Workout = workout
        coreDataWorkout.workoutName = firestoreWorkout.name
        coreDataWorkout.workoutDescription = firestoreWorkout.description
        coreDataWorkout.workoutDate = firestoreWorkout.date
        CoreDataManager.shared.saveContext()
        return coreDataWorkout
    }
    
    
    // MARK: - Delete
    func deleteWorkout(workout: Workout, completion: @escaping (Result<Void, Error>) -> Void) {
        if let firestoreWorkout = convertToFirestoreWorkout(workout), let firestoreWorkoutId = firestoreWorkout.id {
            deleteFirestoreWorkout(workoutId: firestoreWorkoutId) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    do {
                        try self.deleteCoreDataWorkout(workoutId: firestoreWorkoutId)
                        completion(.success(()))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            }
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Workout id not found"])))
        }
    }
    
    private func deleteFirestoreWorkout(workoutId: String, completion: @escaping (Error?) -> Void) {
        db.collection("workouts").document(workoutId).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
                completion(error)
            } else {
                print("Document successfully removed!")
                completion(nil)
            }
        }
    }
    
    private func deleteCoreDataWorkout(workoutId: String) throws {
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", workoutId)
        
        let workouts = try CoreDataManager.shared.context.fetch(fetchRequest)
        
        if let workout = workouts.first {
            CoreDataManager.shared.context.delete(workout)
            CoreDataManager.shared.saveContext()
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Workout not found in CoreData"])
        }
    }
}

extension FirestoreWorkoutManager {
    func convertToFirestoreWorkout(_ workout: Workout) -> FirestoreWorkout? {
        return FirestoreWorkout(from: workout)
    }
}
