//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Sergei Semko on 7/29/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "result_background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "YOUR RESULT"
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 80, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var mainStackView: UIStackView?
    
    private let recalculateButton = UIButton(isBackgroundWhite: true)
    
    // MARK: - Private Properties
    
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    // MARK: - Public Properties
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
    }
    
    // MARK: - Set Views
    
    private func setViews() {
        
        resultLabel.text = bmiValue
        descriptionLabel.text = advice
        view.backgroundColor = color
        
        mainStackView = UIStackView(
            axis: .vertical,
            distribution: .fillProportionally,
            arrangedSubviews: [
                titleLabel,
                resultLabel,
                descriptionLabel,
            ]
        )
        
        guard let mainStackView else { return }
        
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        view.addSubview(recalculateButton)
        
        recalculateButton.addTarget(self, action: #selector(recalculateButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func recalculateButtonTapped(_ sender: UIButton) {
        notificationFeedbackGenerator.notificationOccurred(.error)
        dismiss(animated: true)
    }

}

private extension ResultViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        guard let mainStackView else { return }
        
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            recalculateButton.heightAnchor.constraint(equalToConstant: 51),
            recalculateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recalculateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
