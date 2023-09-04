//
//  UIView + Extension.swift
//  Flash Chat iOS13
//
//  Created by Sergei Semko on 8/3/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func makeShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowRadius = 10
    }
}
