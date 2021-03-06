//
//  DailyExercises.swift
//  DailyHEP
//
//  Created by jeff on 3/10/22.
//

import Foundation

struct DailyExercises: Equatable, Identifiable {
    var id: String = UUID().uuidString
    var exerciseName: String
    var dueByDate: Date
    var isComplete: Bool = false
    var notes: String? = nil
    
}

extension Array where Element == DailyExercises {
    func indexOfExercises(with id: DailyExercises.ID) -> Self.Index {
        guard let index = firstIndex(where: {$0.id == id}) else {
            fatalError()
        }
        return index
    }
}


#if DEBUG
extension DailyExercises {
    static var sampleData: [DailyExercises] {
        [
            DailyExercises(exerciseName: "Elbow Flexion", dueByDate: Date().addingTimeInterval(800.0), notes: "Arm straight down, then touch your shoulder"),
            DailyExercises(exerciseName: "Shoulder Extension", dueByDate: Date().addingTimeInterval(14000.0), notes: "Arm straight down, then slowly rach back"),
            DailyExercises(exerciseName: "Wrist Rotations", dueByDate: Date().addingTimeInterval(60000.0), notes: "Elbow bent with arms on table, turn palm up then turn palm down")
        ]
    }
}
#endif

