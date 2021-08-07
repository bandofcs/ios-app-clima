//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//
import CoreLocation
import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager=WeatherManager()
    var locationManager=CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // To use UITextFileDelegate protocol on searchTextField. It includes function which decides actions from searchTextField UIView. Assign the delegate in UITextField to this view controller
        searchTextField.delegate=self
        // Remember to assign the delegate to this View controller
        weatherManager.delegate=self
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
//MARK: - WeatherManagerDelegate
}
extension WeatherViewController:WeatherManagerDelegate{
    func didUpdateWeather(weather:WeatherModel){
        DispatchQueue.main.sync {
            temperatureLabel.text=weather.temperatureString
            conditionImageView.image=UIImage(systemName: weather.condition)
            cityLabel.text=weather.name
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - UITextFieldDelegate
extension WeatherViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else{
            textField.placeholder="Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city=searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text=""
    }
}
//MARK: - CLLocationManagerDelegate
extension WeatherViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location=locations.last{
            let lat=location.coordinate.latitude
            let lon=location.coordinate.longitude
            locationManager.stopUpdatingLocation()
            weatherManager.fetchWeather(latitude:lat,longitude:lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
