//
//  ExerciseViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/24/22.
//

import Foundation

protocol ExerciseViewModel {
    var exerciseData: Observable<Exercise?> { get }

    func getExercise(unit: Int, exercise: Int)
    func isExerciseCorrect(text: String) -> Bool
    func goToNextExercise()
}

class DefaultExerciseViewModel: ExerciseViewModel {
    var exerciseData = Observable<Exercise?>(Exercise())
    private var unitNumber = Observable<Int>(0)
    private var exerciseNumber = Observable<Int>(0)
    private let exerciseUseCase: ExerciseUseCase

    init(exerciseUseCase: ExerciseUseCase) {
        self.exerciseUseCase = exerciseUseCase
    }

    func getExercise(unit: Int, exercise: Int) {
        unitNumber.value = unit
        exerciseNumber.value = exercise
        getAnswer()
        getImage()
        getSound()
    }

    func isExerciseCorrect(text: String) -> Bool {
        text.lowercased().replacingOccurrences(of: "?", with: "") == exerciseData.value?.answer?.lowercased().replacingOccurrences(of: "?", with: "")
    }

    func goToNextExercise() {
        exerciseUseCase.updateExercise(unit: unitNumber.value, exercise: exerciseNumber.value) { userModel in
            guard let userModel = userModel else { return }
            let user = User.fromModel(model: userModel)
            guard let unit = user.unit, let exercise = user.exercise else { return }

            self.getExercise(unit: unit, exercise: exercise)
        }
    }

    private func getAnswer() {
        exerciseUseCase.fetchExerciseAnswer(unit: unitNumber.value, exercise: exerciseNumber.value) { result in
            switch result {
            case .success(let answer):
                self.exerciseData.value?.answer = answer
            case .failure(_):
                break
            }
        }
    }

    private func getImage() {
        exerciseUseCase.fetchExerciseImage(unit: unitNumber.value, exercise: exerciseNumber.value) { result in
            switch result {
            case .success(let data):
                self.exerciseData.value?.image = data
            case .failure(_):
                break
            }
        }
    }

    private func getSound() {
        exerciseUseCase.fetchExerciseSound(unit: unitNumber.value, exercise: exerciseNumber.value) { result in
            switch result {
            case .success(let url):
                self.exerciseData.value?.sound = url
            case .failure(_):
                break
            }
        }
    }
}
