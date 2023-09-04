//
//  UIButton + Extension.swift
//  Flash Chat iOS13
//
//  Created by Sergei Semko on 8/3/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    convenience init(titleColor: UIColor?, backgroundColor: UIColor? = .clear) {
        self.init(type: .system)
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
