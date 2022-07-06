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
        
        updateSnapshot()
        
        collectionView.dataSource = dataSource
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString("Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = exercises[indexPath.item].id
        showDetail(for: id)
        return false
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .orange
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func showDetail(for id: DailyExercises.ID) {
        let exercises = exercise(for: id)
        let viewController = ExerciseViewController(exercise: exercises) { [weak self] exercise in
            self?.update(exercise, with: id)
            self?.updateSnapshot(reloading: [exercise.id])
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    

    
//    func updateTest(_ exercise: DailyExercises, with id: DailyExercises.ID) {
//        let index = exercises.indexOfExercises(with: id)
//        exercises[index] = exercise
//    }
    
}

