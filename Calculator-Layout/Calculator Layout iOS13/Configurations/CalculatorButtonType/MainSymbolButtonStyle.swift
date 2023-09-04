//
//  MainSymbolButtonStyle.swift
//  Calculator Layout iOS13
//
//  Created by Sergei Semko on 7/17/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

struct MainSymbolButtonType: CalculatorButtonType {
    var `default`: CalculatorButtonConfiguration = MainSymbolTypeDefaultButtonConfiguration()
}


struct MainSymbolTypeDefaultButtonConfiguration: CalculatorButtonConfiguration {
    let backgroundColor: UIColor = UIColor.orange
}


extension CalculatorButtonType where Self == MainSymbolButtonType {
    static var mainSymbol: CalculatorButtonType { MainSymbolButtonType() }
}
