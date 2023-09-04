//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

enum AuthorizationType: String {
    case register = "Register"
    case logIn = "Log In"
}

class RegisterViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let emailTextField = UITextField(
        placeholder: K.emailName,
        color: UIColor(named: K.BrandColors.blue)
    )
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: K.textFieldImageName)
        return imageView
    }()
    
    private let passwordTextfield = UITextField(
        placeholder: K.passwordName,
        color: .black
    )
    
    private let registerButton = UIButton(
        titleColor: UIColor(named: K.BrandColors.blue)
    )
    
    // MARK: - Public Properties
    
    public var authorizationType: AuthorizationType?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        
        switch authorizationType {
        case .register:
            view.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
            registerButton.setTitle(K.registerName, for: .normal)
        case .logIn:
            view.backgroundColor = UIColor(named: K.BrandColors.blue)
            registerButton.setTitle(K.logInName, for: .normal)
            registerButton.setTitleColor(.white, for: .normal)
        default:
            break
        }
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(imageView)
        imageView.addSubview(passwordTextfield)
        mainStackView.addArrangedSubview(registerButton)
        
        emailTextField.makeShadow()
        
        passwordTextfield.isSecureTextEntry = true
        
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }
    
    @objc
    private func registerPressed(_ sender: UIButton) {
        if sender.currentTitle == K.logInName {
            
            guard let email = emailTextField.text, let password = passwordTextfield.text else { return }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let chatViewController = ChatViewController()
                    strongSelf.navigationController?.pushViewController(chatViewController, animated: true)
                }
            }
        } else {
            guard let email = emailTextField.text, let password = passwordTextfield.text else { return }
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let chatViewController = ChatViewController()
                    self.navigationController?.pushViewController(chatViewController, animated: true)
                }
            }
        }
    }
    
}

// MARK: - Setup Constraints

extension RegisterViewController {
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalTo(view).inset(36)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(137)
            make.leading.trailing.equalTo(view)
        }
        
        passwordTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-62)
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(45)
        }
    }
}

