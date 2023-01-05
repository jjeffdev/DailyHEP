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
    var filteredReminders: [DailyExercises] {
        return exercises.filter { listStyle.shouldInclude(date: $0.dueByDate) }.sorted { $0.dueByDate < $1.dueByDate }
    }
    var listStyle: ExerciseListStyle = .today
    let listStyleSegmentedControl = UISegmentedControl(items: [ExerciseListStyle.today.name, ExerciseListStyle.future.name, ExerciseListStyle.all.name])
    var headerView: ProgressHeaderView?
    
    
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .blue
        
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
        
        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        listStyleSegmentedControl.addTarget(self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        navigationItem.titleView = listStyleSegmentedControl
                
        updateSnapshot()
        
        collectionView.dataSource = dataSource
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ProgressHeaderView.elementKind, handler: supplementaryRegistrationHandler)
        dataSource.supplementaryViewProvider = {supplementaryView, elementKind, IndexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: IndexPath)
        }
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString("Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = filteredReminders[indexPath.item].id
        showDetail(for: id)
        return false
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = true
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
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
    
    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
            self?.deleteExercise(with: id)
            self?.updateSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    

    
//    func updateTest(_ exercise: DailyExercises, with id: DailyExercises.ID) {
//        let index = exercises.indexOfExercises(with: id)
//        exercises[index] = exercise
//    }
    
    private func supplementaryRegistrationHandler(progressView: ProgressHeaderView, elementKind: String, indexPath: IndexPath) {
        headerView = progressView
    }
}

