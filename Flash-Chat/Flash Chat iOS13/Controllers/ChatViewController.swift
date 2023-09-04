//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ChatViewController: UIViewController {
    
    // MARK: - UI
    
    private let tableView = UITableView()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: K.BrandColors.purple)
        return containerView
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = K.enterMessagePlaceholder
        textField.textColor = UIColor(named: K.BrandColors.purple)
        textField.tintColor = UIColor(named: K.BrandColors.purple)
        return textField
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: K.enterButtonImageName), for: .normal)
        return button
    }()
    
    private lazy var logOut = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTap))
    
    // MARK: - Private Properties
    
    private var messages: [Message] = []
    private let db = Firestore.firestore()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupDelegates()
        setupViews()
        setupConstraints()
        loadMessages()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        title = K.appName
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = logOut
        logOut.tintColor = .systemRed
        
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.blue)
        
        tableView.backgroundColor = .white
        tableView.register(MessageCell.self, forCellReuseIdentifier: K.cellIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        
        view.addSubview(containerView)
        containerView.addSubview(messageTextField)
        containerView.addSubview(enterButton)
        
        enterButton.addTarget(self, action: #selector(tapEnterButton), for: .touchUpInside)
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        messageTextField.delegate = self
    }
    
    private func setupNotifications() {
        NotificationCenter.default
            .addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: nil
            ) { notification in
                if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    if !self.messages.isEmpty {
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    self.view.frame.origin.y = -keyboardSize.height
                }
            }
        
        NotificationCenter.default
            .addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: nil
            ) { notification in
                self.view.frame.origin.y = 0.0
            }
    }
    
    private func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { [weak self] querySnapshot, error in
            guard let strongSelf = self else { return }
            strongSelf.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                guard let snapshotDocuments = querySnapshot?.documents else { return }

                for doc in snapshotDocuments {
                    let data = doc.data()
                    guard let sender = data[K.FStore.senderField] as? String,
                          let messageBody = data[K.FStore.bodyField] as? String else { return }
                    strongSelf.messages.append(Message(sender: sender, body: messageBody))

                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        let indexPath = IndexPath(row: strongSelf.messages.count - 1, section: 0)
                        strongSelf.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func tapEnterButton(_ sender: UIButton) {
        guard let messageBody = messageTextField.text,
              let messageSender = Auth.auth().currentUser?.email else { return }
        
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: messageSender,
            K.FStore.bodyField: messageBody,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]) { error in
            if let e = error {
                print("There was an issue saving data to Firestore. \(e)")
            } else {
                DispatchQueue.main.async {
                    self.messageTextField.text = ""
                }
            }
        }
    }
    
    @objc
    private func logoutTap(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - Setup Constraints

extension ChatViewController {
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
            make.top.equalTo(tableView.snp.bottom)
        }
        
        messageTextField.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(messageTextField.snp.trailing).offset(20)
            make.height.width.equalTo(40)
        }
    }
}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MessageCell else {
            fatalError()
        }
        
        let message = messages[indexPath.row]
        
        let sender: Sender = message.sender == Auth.auth().currentUser?.email ? .me : .you
        cell.configure(with: message, sender: sender)
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITextFieldDelegate

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == messageTextField {
            messageTextField.resignFirstResponder()
        }
        return false
    }
}
