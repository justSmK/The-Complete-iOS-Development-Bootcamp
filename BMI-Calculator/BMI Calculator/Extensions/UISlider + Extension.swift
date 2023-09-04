//
//  UISlider + Extension.swift
//  BMI Calculator
//
//  Created by Sergei Semko on 7/29/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit.UISlider

extension UISlider {
    convenience init(maximumValue: Float) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.maximumValue = maximumValue
        self.value = maximumValue / 2
        let color = UIColor(red: 0.45, green: 0.45, blue: 0.82, alpha: 0.5)
        self.thumbTintColor = color
        self.minimumTrackTintColor = color
    }
}
