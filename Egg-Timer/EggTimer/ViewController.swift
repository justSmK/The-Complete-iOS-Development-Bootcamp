//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "How do you like your eggs?"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var eggsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var softEggImageView = UIImageView(imageName: "soft_egg")
    private lazy var mediumEggImageView = UIImageView(imageName: "medium_egg")
    private lazy var hardEggImageView = UIImageView(imageName: "hard_egg")
    
    private lazy var softEggButton = UIButton(text: "Soft")
    private lazy var mediumEggButton = UIButton(text: "Medium")
    private lazy var hardEggButton = UIButton(text: "Hard")
    
    private lazy var timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressTintColor = .systemYellow
        view.trackTintColor = .systemGray
        return view
    }()
    
    // MARK: - Private Properties
    private let eggTimes = ["Soft": 30, "Medium": 42, "Hard": 72]
    private var totalTime = 0
    private var secondPassed = 0
    private var timer = Timer()
    private var player: AVAudioPlayer?
    private var nameSoundTimer = "alarm_sound"
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        setupConstraints()
    }
    
    // MARK: - Business Logic
    
    private func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc
    private func eggsButtonsTapped(_ sender: UIButton) {
        timer.invalidate()
        progressView.setProgress(0, animated: true)
        secondPassed = 0
        
        let hardness = sender.titleLabel?.text ?? "error"
        titleLabel.text = "You should \(hardness)"
        
        totalTime = eggTimes[hardness] ?? 0
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc
    private func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            progressView.setProgress(percentageProgress, animated: true)
        } else {
            playSound(nameSoundTimer)
            timer.invalidate()
            secondPassed = 0
            titleLabel.text = "That's done! Let's go repeats?"
            progressView.setProgress(1, animated: true)
        }
    }

}


// MARK: - Set Views and Set Constraints
extension ViewController {
    private func setViews() {
        view.backgroundColor = .cyan
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(eggsStackView)
        mainStackView.addArrangedSubview(timerView)
        
        eggsStackView.addArrangedSubview(softEggImageView)
        eggsStackView.addArrangedSubview(mediumEggImageView)
        eggsStackView.addArrangedSubview(hardEggImageView)
        
        softEggImageView.addSubview(softEggButton)
        mediumEggImageView.addSubview(mediumEggButton)
        hardEggImageView.addSubview(hardEggButton)
        
        softEggButton.addTarget(self, action: #selector(eggsButtonsTapped), for: .touchUpInside)
        mediumEggButton.addTarget(self, action: #selector(eggsButtonsTapped), for: .touchUpInside)
        hardEggButton.addTarget(self, action: #selector(eggsButtonsTapped), for: .touchUpInside)
        
        timerView.addSubview(progressView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            
            softEggButton.topAnchor.constraint(equalTo: softEggImageView.topAnchor),
            softEggButton.bottomAnchor.constraint(equalTo: softEggImageView.bottomAnchor),
            softEggButton.leadingAnchor.constraint(equalTo: softEggImageView.leadingAnchor),
            softEggButton.trailingAnchor.constraint(equalTo: softEggImageView.trailingAnchor),
            
            mediumEggButton.topAnchor.constraint(equalTo: mediumEggImageView.topAnchor),
            mediumEggButton.bottomAnchor.constraint(equalTo: mediumEggImageView.bottomAnchor),
            mediumEggButton.leadingAnchor.constraint(equalTo: mediumEggImageView.leadingAnchor),
            mediumEggButton.trailingAnchor.constraint(equalTo: mediumEggImageView.trailingAnchor),
            
            hardEggButton.topAnchor.constraint(equalTo: hardEggImageView.topAnchor),
            hardEggButton.bottomAnchor.constraint(equalTo: hardEggImageView.bottomAnchor),
            hardEggButton.leadingAnchor.constraint(equalTo: hardEggImageView.leadingAnchor),
            hardEggButton.trailingAnchor.constraint(equalTo: hardEggImageView.trailingAnchor),
        ])
    }
}
