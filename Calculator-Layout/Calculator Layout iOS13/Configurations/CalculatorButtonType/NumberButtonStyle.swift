//
//  NumberButtonStyle.swift
//  Calculator Layout iOS13
//
//  Created by Sergei Semko on 7/17/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

struct NumberButtonType: CalculatorButtonType {
    var `default`: CalculatorButtonConfiguration = NumberTypeDefaultButtonConfiguration()
}


struct NumberTypeDefaultButtonConfiguration: CalculatorButtonConfiguration {
    let backgroundColor: UIColor = UIColor.blue
}


extension CalculatorButtonType where Self == NumberButtonType {
    static var number: CalculatorButtonType { NumberButtonType() }
}
