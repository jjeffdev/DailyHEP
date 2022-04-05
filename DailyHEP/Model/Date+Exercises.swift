//
//  Date+Exercises.swift
//  DailyHEP
//
//  Created by jeff on 3/16/22.
//

import Foundation

extension Date {
    
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeText = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateAndTimeText, dateText, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date discription")
        } else {
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}


