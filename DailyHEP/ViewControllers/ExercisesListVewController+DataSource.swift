//
//  ExercisesVewController.swift
//  DailyHEP
//
//  Created by jeff on 3/19/22.
//

import Foundation
import UIKit

extension ExercisesListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let dailyExercises = DailyExercises.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = dailyExercises.exercise
        contentConfiguration.secondaryText = dailyExercises.dueByDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: dailyExercises)
        doneButtonConfiguration.tintColor = .exercisesListCellDoneButtonTint
        cell.accessories = [ .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]
        
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .exercisesListCellBackground
        cell.backgroundConfiguration = backgroundConfig
    }
    
    private func doneButtonConfiguration(for dailyExercise: DailyExercises) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = dailyExercise.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
        
    }
}
