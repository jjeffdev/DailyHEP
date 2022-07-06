//
//  ExercisesListViewController+Action.swift
//  DailyHEP
//
//  Created by Jeff on 4/21/22.
//

import Foundation
import UIKit

extension ExercisesListViewController {
    @objc func didPressDoneButton(_ sender: ExerciseDoneButton) {
        guard let id = sender.id else {return}
        completeExercise(with: id)
    }
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func didPressAddButton(_ sender:UIBarButtonItem) {
        let exercise = DailyExercises(exerciseName: "", dueByDate: Date.now)
        let viewController = ExerciseViewController(exercise: exercise) { [weak self] exercise in
            
        }
        viewController.isAddingNewExercise = true
        viewController.setEditing(true, animated: false)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
}
