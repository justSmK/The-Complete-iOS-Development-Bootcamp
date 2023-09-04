//
//  Constants .swift
//  Clima
//
//  Created by Sergei Semko on 7/31/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

enum Constants {
    static var id: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "API_KEY", ofType: "plist") else {
                fatalError("Couldn't find file 'API_KEY.plist'.")
            }
            
            #warning("'NSDictionary(contentsOfFile:)' will be deprecated in a future version of iOS")
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'API_KEY.plist'.")
            }
            
            if (value.starts(with: "_")) {
                fatalError("Register developer account and get an API key at https://openweathermap.org")
            }
            
            return value
        }
    }
    static let background = "background"
    static let weatherColor = "weatherColour"
    static let celsius = "°C"
    static let searchSF = "magnifyingglass"
    static let geoSF = "location.circle.fill"
    static let search = "Search"
    static let conditionSF = "cloud.rain"
}

enum ImagesNames {
    static let cloudBolt = "cloud.bolt"
    static let cloudDrizzle = "cloud.drizzle"
    static let cloudRain = "cloud.rain"
    static let cloudSnow = "cloud.snow"
    static let cloudFog = "cloud.fog"
    static let sunMax = "sun.max"
    static let cloud = "cloud"
}
