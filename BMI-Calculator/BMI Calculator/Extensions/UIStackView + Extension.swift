//
//  UIStackView + Extension.swift
//  BMI Calculator
//
//  Created by Sergei Semko on 7/29/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit.UIStackView

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, arrangedSubviews: [UIView]) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.distribution = distribution
        self.spacing = 0
    }
}
