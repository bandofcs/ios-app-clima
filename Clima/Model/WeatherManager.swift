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
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){
        //Create the URL
        if let url=URL(string: urlString){
            //Create a URLsession
            let session=URLSession(configuration: .default)
            //Give the session a task
            let task=session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData=data{
                    parseJSON(weatherData: safeData)
                }
            }
            //Start the task
            task.resume()
        }
    }

    func parseJSON(weatherData:Data){
        let decoder=JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self,from:weatherData)
            print(decodedData.weather[0].description)
        }catch{
            print(error)
        }
    }
}
