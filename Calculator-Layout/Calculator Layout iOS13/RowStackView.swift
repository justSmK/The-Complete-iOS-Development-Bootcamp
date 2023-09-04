//
//  RowStackView.swift
//  Calculator Layout iOS13
//
//  Created by Sergei Semko on 7/14/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class RowStackView: UIStackView {

    convenience init(arrangedCalculatorButtons: [UIView]) {
        self.init(arrangedSubviews: arrangedCalculatorButtons)
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 0.5
    }

}
