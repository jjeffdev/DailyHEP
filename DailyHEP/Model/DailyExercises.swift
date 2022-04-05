//
//  DailyExercises.swift
//  DailyHEP
//
//  Created by jeff on 3/10/22.
//

import Foundation

struct DailyExercises {
    var exercise: String
    var dueByDate: Date
    var isComplete: Bool = false
    var notes: String? = nil
    
}

#if DEBUG
extension DailyExercises {
    static var sampleData: [DailyExercises] {
        [
            DailyExercises(exercise: "Elbow Flexion", dueByDate: Date().addingTimeInterval(800.0), notes: "Arm straight down, then touch your shoulder"),
            DailyExercises(exercise: "Shoulder Extension", dueByDate: Date().addingTimeInterval(14000.0), notes: "Arm straight down, then slowly rach back"),
            DailyExercises(exercise: "Wrist Rotations", dueByDate: Date().addingTimeInterval(60000.0), notes: "Elbow bent with arms on table, turn palm up then turn palm down")
        ]
    }
}
#endif

