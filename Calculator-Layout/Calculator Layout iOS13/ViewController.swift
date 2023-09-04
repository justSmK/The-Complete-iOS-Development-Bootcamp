//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var calculatorSigns = [
        ["%", "+/-", "AC", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .right
        return label
    }()

    private let resultLabelView: UIView = UIView()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        settingsLabel()
        settingVerticalStackView()
    }
    
    private func settingsLabel() {
        resultLabelView.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: resultLabelView.topAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: resultLabelView.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: resultLabelView.trailingAnchor, constant: -20),
            resultLabel.bottomAnchor.constraint(equalTo: resultLabelView.bottomAnchor)
        ])
        
        verticalStackView.addArrangedSubview(resultLabelView)
    }
    
    private func settingVerticalStackView() {
        var rowsOfStacks = [RowStackView]()
        
        for row in calculatorSigns {
            var arrayOfButtons = [UIView]()
            for char in row {
                var newButton: CalculatorButton
                guard char != "AC" && char != "+/-" else {
                    newButton = CalculatorButton(title: char, type: .symbol, state: .default)
                    arrayOfButtons.append(newButton)
                    continue
                }
                let character = Character(char)
                
                if char == row.last {
                    newButton = CalculatorButton(title: char, type: .mainSymbol, state: .default)
                } else if character.isNumber {
                    newButton = CalculatorButton(title: char, type: .number, state: .default)
                } else {
                    newButton = CalculatorButton(title: char, type: .symbol, state: .default)
                }
                arrayOfButtons.append(newButton)
            }
            
            var rowStack: RowStackView
            
            if arrayOfButtons.count != 4 {
                let lastTwoElements = Array([arrayOfButtons.removeLast(), arrayOfButtons.removeLast()].reversed())
                let halfWidthStackView = RowStackView(arrangedCalculatorButtons: lastTwoElements)
                arrayOfButtons.append(halfWidthStackView)
            }
            
            rowStack = RowStackView(arrangedCalculatorButtons: arrayOfButtons)
            rowsOfStacks.append(rowStack)
        }
        
        for element in rowsOfStacks {
            verticalStackView.addArrangedSubview(element)
        }
        
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
