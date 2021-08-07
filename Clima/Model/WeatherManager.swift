//
//  WeatherManager.swift
//  Clima
//
//  Created by CSD on 4/8/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error:Error)
}
struct WeatherManager {
    var delegate : WeatherManagerDelegate?
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid={apikey}&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString="\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString="\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
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
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData=data{
                    if let weather = parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            //Start the task
            task.resume()
        }
    }

    func parseJSON(weatherData:Data)->WeatherModel?{
        let decoder=JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self,from:weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temperature = decodedData.main.temp
            let weatherModel = WeatherModel(conditionID: id, name: name, temperature: temperature)
            return weatherModel
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }

}

