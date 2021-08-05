//
//  WeatherData.swift
//  Clima
//
//  Created by CSD on 5/8/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData:Decodable{
    let name:String
    let weather:[Weather]
    let main:Main
}
struct Weather:Decodable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}
struct Main:Decodable {
    let temp:Double
}
