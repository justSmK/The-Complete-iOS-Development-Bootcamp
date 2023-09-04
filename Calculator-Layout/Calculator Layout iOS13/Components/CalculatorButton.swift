//
//  CalculatorButton.swift
//  Calculator Layout iOS13
//
//  Created by Sergei Semko on 7/15/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

protocol CalculatorButtonType {
    var `default`: CalculatorButtonConfiguration { get }
}

protocol CalculatorButtonConfiguration {
    var backgroundColor: UIColor { get }
}

enum CalculatorButtonState {
    case `default`
}

final class CalculatorButton: UIView {
    
    private let title: String
    private let type: CalculatorButtonType
    private let state: CalculatorButtonState
    
    private let button = UIButton(type: .system)
    
    init(title: String, type: CalculatorButtonType, state: CalculatorButtonState) {
        self.title = title
        self.type = type
        self.state = state
        
        super.init(frame: .zero)

        embedView()
        setupConstraints()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var stateConfig: CalculatorButtonConfiguration {
        switch state {
        case .default:
            return type.default
        }
    }
}

// MARK: - Setup view

private extension CalculatorButton {
    func embedView() {
        addSubview(button)
    }
    
    func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
    
    func setupAppearance() {
        button.backgroundColor = stateConfig.backgroundColor
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 32)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        print(button.titleLabel?.text)
    }
}
