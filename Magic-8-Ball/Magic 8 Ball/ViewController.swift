//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constant {
        static let top: CGFloat = 70
        static let heightLabel: CGFloat = 50
        static let widthLabel: CGFloat = 100
        static let imageWidth: CGFloat = 250
        static let imageHeight: CGFloat = 250
        static let fontSize: CGFloat = 32
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 70
    }
    
    private let balls = [
        UIImage(named: "ball1"),
        UIImage(named: "ball2"),
        UIImage(named: "ball3"),
        UIImage(named: "ball4"),
        UIImage(named: "ball5"),
    ]
    
    // MARK: - Private Lazy Properties
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ask Me Anything"
        label.textColor = .white
        label.font = .systemFont(ofSize: Constant.fontSize)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = .init(width: 10, height: 10)
        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ask", for: .normal)
        button.tintColor = .systemBlue
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: Constant.fontSize)
        return button
    }()
    
    private lazy var shakeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You can shake your phone"
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        settingLabel()
        settingImageView()
        settingButton()
        settingShakeLabel()
    }
    
    // MARK: - Screen Settings
    
    private func settingLabel() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.top)
        ])
    }
    
    private func settingImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight)
        ])
    }
    
    private func settingButton() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            button.heightAnchor.constraint(equalToConstant: Constant.heightLabel),
            button.widthAnchor.constraint(equalToConstant: Constant.widthLabel)
        ])
    }
    
    private func settingShakeLabel() {
        view.addSubview(shakeLabel)
        
        NSLayoutConstraint.activate([
            shakeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shakeLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50)
        ])
    }
    
    // MARK: - Action Settings
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        guard let randomBallImage = balls.randomElement() else {
            return
        }
        
        UIView.animate(withDuration: 0.9) {
            self.imageView.alpha = 0
            self.imageView.image = randomBallImage
            self.imageView.alpha = 1
        }
    }
}

// MARK: - Motion

extension ViewController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        
        if motion == .motionShake {
            buttonTapped(button)
        }
    }
}
    
