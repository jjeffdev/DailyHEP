//
//  DetailViewController+Row.swift
//  DailyHEP
//
//  Created by Jeff on 4/27/22.
//

import Foundation
import UIKit

extension ExerciseViewController {
    enum Row: Hashable {
        case header(String)
        case viewDate
        case viewNote
        case viewTime
        case viewTitle
        case editText(String)
        case editDate(Date)
        case editNote(String?)
        
    
    
        var imageName: String? {
            switch self {
            case .viewDate: return "calendar.circle"
            case .viewNote: return "square.and.pencil"
            case .viewTime: return "clock"
            default: return nil
            }
        }
        
        var image: UIImage? {
            guard let imageName = imageName else {return nil}
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .viewTitle: return .headline
            default: return .subheadline
            }
        }
    }
}
