//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var nameButtons = ["A", "C", "B", "F", "G", "E", "D"]
    private var buttonStackView = UIStackView()
    
    private var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        createButtons()
    }
    
    private func createButtons() {
        for (index, nameButton) in nameButtons.enumerated() {
            let multiplierWidth = 0.97 - (0.03 * Double(index))
            createButton(name: nameButton, width: multiplierWidth)
        }
    }
    
    private func createButton(name: String, width: Double) {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(name, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 45)
        button.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        
        button.layer.cornerRadius = 10
        
        buttonStackView.addArrangedSubview(button)
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: width).isActive = true
        
        button.backgroundColor = getColor(for: name)
    }
    
    private func getColor(for name: String) -> UIColor {
        switch name {
        case "A":
            return UIColor.systemRed
        case "C":
            return UIColor.systemOrange
        case "B":
            return UIColor.systemYellow
        case "F":
            return UIColor.systemGreen
        case "G":
            return UIColor.systemIndigo
        case "E":
            return UIColor.systemBlue
        case "D":
            return UIColor.systemPurple
        default:
            return UIColor.white
        }
    }
    
    private func toggleButtonAlpha(_ button: UIButton) {
        button.alpha = button.alpha == 1 ? 0.5 : 1
    }
    
    private func playSound(_ buttonText: String) {
        guard let url = Bundle.main.url(forResource: buttonText, withExtension: "wav") else { return }
        
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc
    private func buttonsTapped(_ sender: UIButton) {
        toggleButtonAlpha(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.toggleButtonAlpha(sender)
        }
        guard let buttonText = sender.currentTitle else { return }
        playSound(buttonText)
    }
}

extension ViewController {
    private func setViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
