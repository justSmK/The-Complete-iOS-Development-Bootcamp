//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Sergei Semko on 8/3/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit
import SnapKit

class MessageCell: UITableViewCell {
    
    // MARK: - Elements
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        stackView.alignment = .bottom
        return stackView
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.youAvatar)
        return imageView
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.meAvatar)
        return imageView
    }()
    
    private lazy var messageView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        messageView.frame = contentView.bounds
        
        messageView.layoutIfNeeded()
        messageView.layer.cornerRadius = messageView.frame.height / 4
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Properties
    
    public func configure(with model: Message, sender: Sender) {
        
        switch sender {
        case .me:
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        case .you:
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageView.backgroundColor = UIColor(named: K.BrandColors.purple)
            messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        messageLabel.text = model.body
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(leftImageView)
        mainStackView.addArrangedSubview(messageView)
        mainStackView.addArrangedSubview(rightImageView)
        messageView.addSubview(messageLabel)
    }
}

// MARK: - Setup Constraints

extension MessageCell {
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
