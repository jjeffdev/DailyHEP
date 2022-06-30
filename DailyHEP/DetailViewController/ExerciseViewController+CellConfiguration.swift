//
//  ExerciseViewController+CellConfiguration.swift
//  DailyHEP
//
//  Created by Jeff on 5/24/22.
//

import UIKit

extension ExerciseViewController {
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = title
        contentConfiguration.onChange = { [weak self] exerciseName in
            self?.workingExercise.exerciseName = exerciseName
        }
        return contentConfiguration
    }
    
    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
        var contentConfiguration = cell.datePickerConfiguration()
        contentConfiguration.date = date
        contentConfiguration.onChange = { [weak self] dueDate in
            self?.workingExercise.dueByDate = dueDate
        }
        return contentConfiguration
    }
    
    func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration {
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = notes
        contentConfiguration.onChange = { [weak self] notes in
            self?.workingExercise.notes = notes
        }
        return contentConfiguration
    }
    
    
    func text(for row: Row) -> String? {
        switch row {
        case .viewDate: return exercise.dueByDate.dayText
        case .viewNote: return exercise.notes
        case .viewTime: return exercise.dueByDate.formatted(date: .omitted, time: .shortened)
        case .viewTitle: return exercise.exerciseName
        default: return nil
        }
    }
}
