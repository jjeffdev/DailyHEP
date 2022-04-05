//
//  RepeatDailyExercise.swift
//  DailyHEP
//
//  Created by jeff on 3/15/22.
//

import Foundation

struct RepeatDailyExercises {
    var exercises: String
    var dueByDate: Date
    var isComplete: Bool = false
    var notes: String? = nil
}

#if DEBUG
extension RepeatDailyExercises {
    static var sampleDataForRepeatDailyExercise = [
        RepeatDailyExercises(exercises: "Upward Dog", dueByDate: Date(), notes: "On the floor lay on your belly, slolwy staring looking up then strighten your amrs by pushing them into the floor")
    ]
}
#endif
