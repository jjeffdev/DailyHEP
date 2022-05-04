//
//  ExerciseViewController.swift
//  DailyHEP
//
//  Created by Jeff on 4/27/22.
//

import Foundation
import UIKit

class ExerciseViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    
    var exercise: DailyExercises
    private var dataSource: DataSource!
    
    init(exercise: DailyExercises) {
        self.exercise = exercise
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize ExerciseViewController from init(exercise:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .viewDate: return exercise.dueByDate.dayText
        case .viewNote: return exercise.notes
        case .viewTime: return exercise.dueByDate.formatted(date: .omitted, time: .shortened)
        case .viewTitle: return exercise.exercise
        }
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .exercisesPrimaryTint
    }

}
