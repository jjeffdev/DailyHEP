//
//  ExercisesListViewController+DataSource.swift
//  DailyHEP
//
//  Created by jeff on 3/19/22.
//

import Foundation
import UIKit

extension ExercisesListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, DailyExercises.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, DailyExercises.ID>
    
    var exerciseCompletedValue: String {
        NSLocalizedString("Completed", comment: "Exercise completed value")
    }
    
    var exerciseNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Exercise not completed value")
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: DailyExercises.ID) {
        let dailyExercises = exercises[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = dailyExercises.exerciseName
        contentConfiguration.secondaryText = dailyExercises.dueByDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: dailyExercises)
        doneButtonConfiguration.tintColor = .exercisesListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: dailyExercises)]
        cell.accessibilityValue = dailyExercises.isComplete ? exerciseCompletedValue : exerciseNotCompletedValue
        cell.accessories = [ .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]
        
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .exercisesListCellBackground
        cell.backgroundConfiguration = backgroundConfig
    }
    
    private func doneButtonConfiguration(for dailyExercise: DailyExercises) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = dailyExercise.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ExerciseDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = dailyExercise.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
        
    }
    
    func add(_ exercise: DailyExercises) {
        exercises.append(exercise)
    }
    
    func deleteExercise(with id: DailyExercises.ID) {
        let index = exercises.indexOfExercises(with: id)
        exercises.remove(at: index)
    }
    
    func exercise(for id: DailyExercises.ID) -> DailyExercises {
        let index = exercises.indexOfExercises(with: id)
        return exercises[index]
    }
    
    func update(_ exercise: DailyExercises, with id: DailyExercises.ID) {
        let index = exercises.indexOfExercises(with: id)
        exercises[index] = exercise
    }


    
    func completeExercise(with id: DailyExercises.ID) {
        var exercise = exercise(for: id)
        exercise.isComplete.toggle()
        update(exercise, with: id)
        updateSnapshot(reloading: [id])
        
    }
    
    func updateSnapshot(reloading idsThatChanged: [DailyExercises.ID] = []) {
        let ids = idsThatChanged.filter { id in filteredReminders.contains(where: {$0.id == id}) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredReminders.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        
    }

    private func doneButtonAccessibilityAction(for exercise: DailyExercises) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Exercise done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeExercise(with: exercise.id)
            return true
        }
        return action
    }
}


