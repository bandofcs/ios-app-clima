//
//  WeatherModel.swift
//  Clima
//
//  Created by CSD on 5/8/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let conditionID:Int
    let name:String
    let temperature:Double
    var temperatureString:String{
        String(format: "%.1f", temperature)
    }
    var condition:String{
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800:
            return "aqi.low"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }
}
