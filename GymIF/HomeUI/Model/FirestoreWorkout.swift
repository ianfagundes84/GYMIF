//
//  Workout.swift
//  GymIF
//
//  Created by Ian Fagundes on 18/05/23.
//

import Foundation
import FirebaseFirestore

public class FirestoreWorkout: Codable {
    var id: String?
    var name: String
    var description: String
    var date: Date
    
    init(name: String, description: String, date: Date) {
        self.name = name
        self.description = description
        self.date = date
    }

    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
              let description = dictionary["description"] as? String,
              let timestamp = dictionary["date"] as? Timestamp
        else { return nil }

        self.name = name
        self.description = description
        self.date = timestamp.dateValue()
    }

    convenience init?(from workout: Workout) {
        guard
            let name = workout.workoutName,
            let description = workout.workoutDescription,
            let date = workout.workoutDate
        else {
            return nil
        }
        
        self.init(name: name, description: description, date: date)
        self.id = workout.id
    }

    var dictionary: [String: Any] {
        return [
            "name": name,
            "description": description,
            "date": Timestamp(date: date)
        ]
    }
}

