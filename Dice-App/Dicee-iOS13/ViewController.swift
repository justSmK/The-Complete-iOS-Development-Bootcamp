//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private enum Constants {
        static let leading: CGFloat = 50
        static let trailing: CGFloat = -50
        static let diceLength: CGFloat = 100
        static let buttonWidth: CGFloat = 128
        static let buttonHeight: CGFloat = 64
    }
    
    // MARK: - Private Lazy Properties
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "GreenBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "DiceLogo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var leftDiceImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "DiceOne")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rightDiceImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "DiceSix")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rollButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Roll", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 32)
        button.tintColor = .white
        button.backgroundColor = UIColor(
            red: 142 / 255,
            green: 41 / 255,
            blue: 37 / 255,
            alpha: 1
        )
        button.layer.cornerRadius = 10
        button.titleEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var middleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var stackViewForDice: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        settingBackgroundImageView()
        settingStackView()
    }
    
    private func settingStackView() {
        
        
        settingLogoImageView()
        
        settingDiceImageView()
        
        settingRollButton()
        
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(bottomView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Screen Settings
    
    private func settingBackgroundImageView() {
        view.insertSubview(backgroundImageView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func settingLogoImageView() {
        topView.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
        ])
    }
    
    private func settingDiceImageView() {
        middleView.addSubview(stackViewForDice)
        
        stackViewForDice.addArrangedSubview(leftDiceImageView)
        stackViewForDice.addArrangedSubview(rightDiceImageView)
        
        NSLayoutConstraint.activate([
            stackViewForDice.centerYAnchor.constraint(equalTo: middleView.centerYAnchor),
            stackViewForDice.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
            stackViewForDice.heightAnchor.constraint(equalTo: middleView.heightAnchor),
            stackViewForDice.widthAnchor.constraint(equalTo: middleView.widthAnchor)
        ])
    }
    
    private func settingRollButton() {
        rollButton.addTarget(self, action: #selector(rollButtonTapped), for: .touchUpInside)
        
        bottomView.addSubview(rollButton)
        
        NSLayoutConstraint.activate([
            rollButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            rollButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            rollButton.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.buttonHeight),
            rollButton.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.buttonWidth)
        ])
    }
    
    // MARK: - Action Settings
    
    @objc
    private func rollButtonTapped(_ sender: UIButton) {
        let diceArray = [
            UIImage(named: "DiceOne"),
            UIImage(named: "DiceTwo"),
            UIImage(named: "DiceThree"),
            UIImage(named: "DiceFour"),
            UIImage(named: "DiceFive"),
            UIImage(named: "DiceSix")
        ]
        
        guard let leftDiceRandomElement = diceArray.randomElement(),
              let rightDiceRandomElement = diceArray.randomElement()
        else {
            return
        }
        
        self.leftDiceImageView.image = leftDiceRandomElement
        self.rightDiceImageView.image = rightDiceRandomElement
    }

}

