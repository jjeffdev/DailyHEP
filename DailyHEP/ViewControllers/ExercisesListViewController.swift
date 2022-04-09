//
//  ViewController.swift
//  DailyHEP
//
//  Created by jeff on 3/9/22.
//

import UIKit

class ExercisesListViewController: UICollectionViewController {
//    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!
    var exercises: [DailyExercises] = DailyExercises.sampleData
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler) /*{ (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let dailyExercises = DailyExercises.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = dailyExercises.exercise
            contentConfiguration.secondaryText = dailyExercises.dueByDate.dayAndTimeText
            cell.contentConfiguration = contentConfiguration
        }*/
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: DailyExercises.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(exercises.map { $0.id })
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
        
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .orange
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
   
}

