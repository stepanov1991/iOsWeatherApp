//
//  WeatherManager.swift
//  iOsWeatherApp
//
//  Created by user on 09.07.2021.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather (_ WeatherManager: WeatherManager, Weather: [WeatherModel])
    func didFailWithError(error: Error)
}

class WeatherManager {
    
    var delegate : WeatherManagerDelegate?
    
    let baseUrl = "https://api.weatherapi.com/v1/forecast.json?key=e4b8432cb6be4e16b8c81319210907&days=9"
    
    func getWeatherForCity(city: String, category: String) {
        
        let urlString = "\(baseUrl)&q=\(city)"
        performRequest(with: urlString)

    }
    
    func performRequest(with urlString: String) {
        if  let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, responce, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if  let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, Weather: weather)                    }
                }
            }
        task.resume()
        }
            }
    
    func parseJSON(_ weatherData: Data) -> [WeatherModel]? {
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            
            
            let totalResults = decoderData
            var weatherArray = [WeatherModel]()
            
            for result in 0...totalResults-1 {
                
              
            }
            
        
            
            return totalResults
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
