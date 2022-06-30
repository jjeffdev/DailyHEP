//
//  DetailViewController+Sections.swift
//  DailyHEP
//
//  Created by Jeff on 5/20/22.
//

import Foundation

extension ExerciseViewController {
    enum Section: Int, Hashable {
        case title
        case note
        case date
        case view
        
        var name: String {
            switch self {
            case .view: return ""
            case .title: return NSLocalizedString("Title", comment: "Title section name")
            case .date: return NSLocalizedString("Date", comment: "Date section name")
            case .note: return NSLocalizedString("Note", comment: "Note sevtion name")
            }
        }
    }
}
