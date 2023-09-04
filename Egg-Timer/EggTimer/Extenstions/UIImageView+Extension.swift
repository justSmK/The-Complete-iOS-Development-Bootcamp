//
//  UIImageView+Extension.swift
//  EggTimer
//
//  Created by Sergei Semko on 7/29/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.isUserInteractionEnabled = true
    }
}
