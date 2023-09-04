//
//  SymbolButtonStyle.swift
//  Calculator Layout iOS13
//
//  Created by Sergei Semko on 7/17/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

struct SymbolButtonType: CalculatorButtonType {
    var `default`: CalculatorButtonConfiguration = SymbolTypeDefaultButtonConfiguration()
}


struct SymbolTypeDefaultButtonConfiguration: CalculatorButtonConfiguration {
    let backgroundColor: UIColor = UIColor.darkGray
}


extension CalculatorButtonType where Self == SymbolButtonType {
    static var symbol: CalculatorButtonType { SymbolButtonType() }
}
