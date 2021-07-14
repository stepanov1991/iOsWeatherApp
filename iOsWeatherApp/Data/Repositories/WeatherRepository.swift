//
//  File.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 12.07.2021.
//

import Foundation


final class WeatherRepository {
    
    static func realtime(city:String, complition:@escaping ((WeatherData?, Error?)->())) {
        WeatherService.realtime(city: city) { remote, error in
            if let error = error {
                complition(nil, error)
                return
            }
            if let remote = remote {
                complition(WeatherData.from(remote: remote), nil)
            }
        }
    }
    
    static func forecast(city:String, complition:@escaping ((ForecastData?, Error?)->())) {
        WeatherService.forecast(city: city) { remote, error in
            if let error = error {
                complition(nil, error)
                return
            }
            if let remote = remote {
                complition(ForecastData.from(remote), nil)
            }
        }
    }
    
}
