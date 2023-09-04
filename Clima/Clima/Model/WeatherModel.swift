//
//  WeatherModel.swift
//  Clima
//
//  Created by Sergei Semko on 7/31/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var getConditionName: String {
        switch conditionId {
        case 200...232:
            return ImagesNames.cloudBolt
        case 300...321:
            return ImagesNames.cloudDrizzle
        case 500...531:
            return ImagesNames.cloudRain
        case 600...622:
            return ImagesNames.cloudSnow
        case 700...781:
            return ImagesNames.cloudFog
        case 800:
            return ImagesNames.sunMax
        case 800...804:
            return ImagesNames.cloudBolt
        default:
            return ImagesNames.cloud
        }
    }
    
    init(conditionId: Int, cityName: String, temperature: Double) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
    }
    
    init(weatherData: WeatherData) {
        self.conditionId = weatherData.weather[0].id
        self.cityName = weatherData.name
        self.temperature = weatherData.main.temp
    }
}
