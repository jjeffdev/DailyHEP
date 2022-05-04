//
//  ExercisesListViewController+Action.swift
//  DailyHEP
//
//  Created by Jeff on 4/21/22.
//

import Foundation

extension ExercisesListViewController {
    @objc func didPressDoneButton(_ sender: ExerciseDoneButton) {
        guard let id = sender.id else {return}
        completeExercise(with: id)
    }
}
