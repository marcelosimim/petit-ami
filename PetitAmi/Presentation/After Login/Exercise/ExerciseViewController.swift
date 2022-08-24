//
//  ExerciseViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/24/22.
//

import InstantSearchVoiceOverlay
import AVFoundation
import UIKit

class ExerciseViewController: UIViewController, Coordinating {
    var coodinator: Coordinator?
    var unit: Int?
    var exercise: Int?
    var player: AVPlayer?
    let voiceOverlayController: VoiceOverlayController = {
        let recordableHandler = {
            return SpeechController(locale: Locale(identifier: "fr_FR"))
        }
        return VoiceOverlayController(speechControllerHandler: recordableHandler)
    }()
    private let exerciseView = AppContainer.shared.resolve(ExerciseView.self)!
    private let viewModel = AppContainer.shared.resolve(ExerciseViewModel.self)!


    override func viewDidLoad() {
        super.viewDidLoad()
        view = exerciseView.contentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrentExerciseInfo()
        setViewModelObservers()
        setupButtons()
        setupTextField()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         NotificationCenter.default.removeObserver(self)
    }

    private func getCurrentExerciseInfo() {
        guard let unit = unit, let exercise = exercise else {
            navigationController?.popViewController(animated: true)
            return
        }
        viewModel.getExercise(unit: unit, exercise: exercise)
    }

    private func setViewModelObservers() {
        viewModel.exerciseData.bind { exercise in
            guard let _ = exercise?.answer, let image = exercise?.image, let _ = exercise?.sound else { return }
            self.exerciseView.setupImage(data: image)
            self.exerciseView.setupComponents(isEnabled: true)
            self.voiceOverlaySettings()
        }
    }

    private func setupButtons() {
        exerciseView.speakerButton.addTarget(self, action: #selector(speakerTapped), for: .touchDown)
        exerciseView.recordButton.addTarget(self, action: #selector(micTapped), for: .touchDown)
    }

    @objc private func speakerTapped() {
        playAudio()
    }

    @objc private func micTapped() {
        startVoiceOverlay()
    }

    private func getExerciseData() -> Exercise? {
        viewModel.exerciseData.value
    }

    private func setupTextField() {
        exerciseView.answerTextField.delegate = self
    }

    private func goToNextExercise() {
        exerciseView.setupComponents(isEnabled: false)
        viewModel.goToNextExercise()
    }
}

// MARK: - Instant Search VoiceOverlay

extension ExerciseViewController {
    private func voiceOverlaySettings(){
        voiceOverlayController.settings.layout.inputScreen.subtitleInitial = ""
        voiceOverlayController.settings.layout.inputScreen.subtitleBullet = ""
        voiceOverlayController.settings.layout.inputScreen.subtitleBulletList = []
        guard let exerciseData = viewModel.exerciseData.value, let answer = exerciseData.answer else {
            return
        }
        voiceOverlayController.settings.layout.inputScreen.titleInProgress = answer
        voiceOverlayController.settings.layout.inputScreen.titleListening = answer
    }

    private func startVoiceOverlay() {
        voiceOverlayController.start(on: self, textHandler: { (text, finished ,any) in
            if finished {
                if self.viewModel.isExerciseCorrect(text: text) {
                    self.goToNextExercise()
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        Alert.alertToCorrect(title: "Resposta incorreta...", message: "Ops... Tente novamente!", controller: self)
                    }
                    print(self.getExerciseData()?.answer, " vs ", text)
                }
            }
        }, errorHandler: { (error) in
                print("voice output: error \(String(describing: error))")
        })
    }
}

// MARK: - AVPlayer

extension ExerciseViewController {
    private func setupAVPlayer() {
        player!.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        self.player!.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }

    private func playAudio() {
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        exerciseView.speakerButton.setImage(.speakerLoading, for: .normal)

        guard let sound = getExerciseData()?.sound else { return }
        let playerItem = AVPlayerItem.init(url: sound)
        self.player = AVPlayer.init(playerItem: playerItem)
        setupAVPlayer()
        self.player!.play()
    }

    @objc func audioDidEnded(){
        exerciseView.speakerButton.setImage(.speaker, for: .normal)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === self.player! {
            if player!.timeControlStatus == .playing {
                exerciseView.speakerButton.setImage(.speakerPlaying, for: .normal)
            }
        }
    }
}

extension ExerciseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        if viewModel.isExerciseCorrect(text: text) {
            exerciseView.answerTextField.defaultState()
            goToNextExercise()
        } else {
            exerciseView.answerTextField.hasErrorState()
        }
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        exerciseView.answerTextField.defaultState()
    }
}
