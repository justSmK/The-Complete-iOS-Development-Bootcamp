//
//  UITextField + Extension.swift
//  Flash Chat iOS13
//
//  Created by Sergei Semko on 8/3/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit.UITextField

extension UITextField {
    convenience init(placeholder: String, color: UIColor?) {
        self.init()
        
        self.placeholder = placeholder
        self.textColor = color
        self.tintColor = color
        
        self.textAlignment = .center
        self.backgroundColor = .white
        self.layer.cornerRadius = 30
        self.font = .systemFont(ofSize: 25)
        
    }
}
