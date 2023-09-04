//
//  UILabel + Extension.swift
//  BMI Calculator
//
//  Created by Sergei Semko on 7/29/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit.UILabel

extension UILabel {
    convenience init(alignment: NSTextAlignment, text: String? = nil) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = alignment
        self.font = .systemFont(ofSize: 17, weight: .light)
        self.textColor = .darkGray
        self.text = text
    }
}
