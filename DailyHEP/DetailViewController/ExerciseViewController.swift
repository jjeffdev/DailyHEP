//
//  ExerciseViewController.swift
//  DailyHEP
//
//  Created by Jeff on 4/27/22.
//

import Foundation
import UIKit

class ExerciseViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var exercise: DailyExercises {
        didSet {
            onChange(exercise)
        }
    }
    var workingExercise: DailyExercises
    var onChange: (DailyExercises) -> Void
    private var dataSource: DataSource!
    
    init(exercise: DailyExercises, onChange: @escaping (DailyExercises) -> Void) {
        self.exercise = exercise
        self.workingExercise = exercise
        self.onChange = onChange
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize ExerciseViewController from init(exercise:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        navigationItem.title = NSLocalizedString("Exercise", comment: "Exercise view controller title")
        navigationItem.rightBarButtonItem = editButtonItem
        
        updateSnapshotForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            prepareForEditing()
        } else {
            prepareForViewing()
        }
    }
    

    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.title, .editText(let title)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case (.date, .editDate(let date)): cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case (.note, .editNote(let notes)): cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
        default: fatalError("Unexpected combination of section and row.")
        }
        cell.tintColor = .exercisesPrimaryTint
    }
    
    private func prepareForViewing() {
        navigationItem.leftBarButtonItem = nil
        if workingExercise != exercise {
            exercise = workingExercise
        }
        updateSnapshotForViewing()
    }
    
    @objc func didCancelEdit() {
        workingExercise = exercise
        setEditing(false, animated: true)
    }
    
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
        updateSnapshotForEditing()
    }
    
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([.header(""), .viewNote, .viewTime, .viewDate, .viewNote], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .date, .note])
        snapshot.appendItems([.header(Section.title.name), .editText(exercise.exerciseName)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name), .editDate(exercise.dueByDate)], toSection: .date)
        snapshot.appendItems([.header(Section.note.name), .editNote(exercise.notes)], toSection: .note)
        
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }

}
