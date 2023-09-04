//
//  CalculateViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "calculate_background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var mainStackView: UIStackView?
    
    private var heightStackView: UIStackView?
    private let heightTitleLabel = UILabel(alignment: .left, text: "height")
    private let heightNumberLabel = UILabel(alignment: .right)
    private let heightSlider = UISlider(maximumValue: 2.5)
    
    
    private var weightStackView: UIStackView?
    private let weightTitleLabel = UILabel(alignment: .left, text: "weight")
    private let weightNumberLabel = UILabel(alignment: .right)
    private let weightSlider = UISlider(maximumValue: 150)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "CALCULATE YOUR BMI"
        return label
    }()
    
    private let calculateButton = UIButton(isBackgroundWhite: false)
    
    // MARK: - Private Properties
    
    private var calculatorBrain = CalculatorBrain()
    
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
    }

    private func setViews() {
        
        heightStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillEqually,
            arrangedSubviews: [heightTitleLabel, heightNumberLabel]
        )
        
        weightStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillEqually,
            arrangedSubviews: [weightTitleLabel, weightNumberLabel]
        )
        
        guard let heightStackView, let weightStackView else { return }
        
        mainStackView = UIStackView(
            axis: .vertical,
            distribution: .fillProportionally,
            arrangedSubviews: [
                titleLabel,
                heightStackView,
                heightSlider,
                weightStackView,
                weightSlider,
                calculateButton,
            ]
        )
        
        guard let mainStackView else { return }
        
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        heightSlider.addTarget(self, action: #selector(heightSliderChanged), for: .valueChanged)
        weightSlider.addTarget(self, action: #selector(weightSliderChanged), for: .valueChanged)
    }
    
    @objc
    private func heightSliderChanged(_ sender: UISlider) {
        
        let currentValue = sender.value
        var intensity: CGFloat = 0
        
        if 1.90... ~= currentValue {
            intensity = 1
        }
        
        if 1.70..<1.90 ~= currentValue {
            intensity = 0.8
        }
        
        if 1.50..<1.70 ~= currentValue {
            intensity = 0.6
        }
        
        if 1.20..<1.50 ~= currentValue {
            intensity = 0.4
        }
        
        if ...1.20 ~= currentValue {
            intensity = 0.2
        }
        
        impactFeedbackGenerator.impactOccurred(intensity: intensity)
        
        heightNumberLabel.text = String(format: "%.2f", sender.value) + "m"
    }
    
    @objc
    private func weightSliderChanged(_ sender: UISlider) {

        let currentValue = sender.value
        var intensity: CGFloat = 0
        
        if 101... ~= currentValue {
            intensity = 1
        }
        
        if 81...100 ~= currentValue {
            intensity = 0.8
        }
        
        if 41...80 ~= currentValue {
            intensity = 0.6
        }
        
        if 0..<40 ~= currentValue  {
            intensity = 0.4
        }
        
        impactFeedbackGenerator.impactOccurred(intensity: intensity)
        
        weightNumberLabel.text = String(format: "%.0f", sender.value) + "k"
    }
    
    @objc
    private func calculateButtonTapped(_ sender: UIButton) {
        
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weight: weight)
        
        let resultViewController = ResultViewController()
        resultViewController.modalTransitionStyle = .flipHorizontal
        resultViewController.modalPresentationStyle = .fullScreen
        
        resultViewController.bmiValue = calculatorBrain.getBMIValue()
        resultViewController.color = calculatorBrain.getColor()
        resultViewController.advice = calculatorBrain.getAdvice()
        
        notificationFeedbackGenerator.notificationOccurred(.success)
        
        present(resultViewController, animated: true)
    }
}

private extension CalculateViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        guard let mainStackView,
              let heightStackView,
              let weightStackView
            else { return }
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            heightStackView.heightAnchor.constraint(equalToConstant: 21),
            heightSlider.heightAnchor.constraint(equalToConstant: 60),
            
            weightStackView.heightAnchor.constraint(equalToConstant: 21),
            weightSlider.heightAnchor.constraint(equalToConstant: 60),
            
            calculateButton.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
}
