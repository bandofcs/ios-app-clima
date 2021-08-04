//
//  WeatherManager.swift
//  Clima
//
//  Created by CSD on 4/8/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager {
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid={apikey}&units=metric"
    func fetchWeather(cityName: String){
        let urlString="\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
    func performRequest(urlString:String){
        if let url=URL(string: urlString){
            let session=URLSession(configuration: .default)
            let task=session.dataTask(with: url, completionHandler: handle)
            task.resume()
        }
    }
    func handle(data:Data?, response:URLResponse?,error:Error?){
        if error != nil{
            print(error!)
            return
        }
        if let safeData=data{
            let dataString=String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
