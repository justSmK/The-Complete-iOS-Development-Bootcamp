//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: K.BrandColors.blue)
        label.font = .systemFont(ofSize: 50, weight: .black)
        return label
    }()
    
    private let registerButton = UIButton(
        titleColor: UIColor(named: K.BrandColors.blue),
        backgroundColor: UIColor(named: K.BrandColors.lightBlue)
    )
    
    private let logInButton = UIButton(
        titleColor: .white,
        backgroundColor: .systemTeal
    )
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fillData()
        animationText()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .systemYellow
        
        view.addSubview(titleLabel)
        view.addSubview(registerButton)
        view.addSubview(logInButton)
        
        registerButton.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(buttonsTapped), for: .touchUpInside)
    }
    
    private func fillData() {
//        titleLabel.text = K.appName
        registerButton.setTitle(K.registerName, for: .normal)
        logInButton.setTitle(K.logInName, for: .normal)
    }
    
    private func animationText() {
        titleLabel.text = ""
        let titleText = K.appName
        
        for letter in titleText.enumerated() {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(letter.offset), repeats: false) { _ in
                self.titleLabel.text! += String(letter.element)
            }
        }
    }
    
    @objc
    private func buttonsTapped(_ sender: UIButton) {
        let nextViewController = RegisterViewController()
        
        if sender.currentTitle == K.registerName {
            nextViewController.authorizationType = .register
        } else if sender.currentTitle == K.logInName {
            nextViewController.authorizationType = .logIn
        }
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - Setup Constraints

extension WelcomeViewController {
    private func setupConstraints() {
        titleLabel.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
        
        logInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(K.Size.buttonSize)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(K.Size.buttonSize)
            make.bottom.equalTo(logInButton.snp.top).offset(-K.Size.buttonOffset)
        }
    }
}

