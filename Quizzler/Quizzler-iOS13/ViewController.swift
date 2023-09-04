//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Background-Bubbles")
        imageView.image = image
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Question"
        return label
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        return button
    }()
    
    private lazy var thirdButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        return button
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.5
        progressView.trackTintColor = .white
        progressView.progressTintColor = UIColor(red: 1.00, green: 0.46, blue: 0.66, alpha: 1.00)
        return progressView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.15, green: 0.17, blue: 0.29, alpha: 1.00)
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(scoreLabel)
        mainStackView.addArrangedSubview(questionLabel)
        mainStackView.addArrangedSubview(firstButton)
        mainStackView.addArrangedSubview(secondButton)
        mainStackView.addArrangedSubview(thirdButton)
        mainStackView.addArrangedSubview(progressView)
        
        scoreLabel.text = "Score: "
        firstButton.setTitle("first button", for: .normal)
        secondButton.setTitle("second button", for: .normal)
        thirdButton.setTitle("third", for: .normal)
    }
}

// MARK: - Setup Constraints

private extension ViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 102),
            
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            firstButton.heightAnchor.constraint(equalToConstant: 80),
            secondButton.heightAnchor.constraint(equalToConstant: 80),
            thirdButton.heightAnchor.constraint(equalToConstant: 80),
            
            progressView.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
}
