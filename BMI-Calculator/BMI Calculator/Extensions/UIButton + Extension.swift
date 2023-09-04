//
//  UIButton + Extension.swift
//  BMI Calculator
//
//  Created by Sergei Semko on 7/29/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    convenience init(isBackgroundWhite: Bool) {
        self.init(type: .system)
        
        let color = UIColor(red: 0.45, green: 0.45, blue: 0.82, alpha: 0.5)
        let text = isBackgroundWhite ? "RECALCULATE" : "CALCULATE"
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: .normal)
        self.tintColor = isBackgroundWhite ? color : .white
        self.backgroundColor = isBackgroundWhite ? .white : color
        self.layer.cornerRadius = 10
        self.titleLabel?.font = .systemFont(ofSize: 20)
    }
}
