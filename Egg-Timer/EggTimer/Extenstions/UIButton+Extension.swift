//
//  UIButton+Extension.swift
//  EggTimer
//
//  Created by Sergei Semko on 7/29/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(text: String) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        self.tintColor = .white
    }
}
