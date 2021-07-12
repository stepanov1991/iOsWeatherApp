//
//  File.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 12.07.2021.
//

import Foundation


final class WeatherRepository {
    
    static func realite(city:String, complition:@escaping ((WeatherData?, Error?)->())) {
        WeatherService.realite(city: city) { remote, error in
            if let error = error { complition(nil, error) }
            else if let remote = remote {
                complition(WeatherData.from(remote: remote), nil)
            }
        }
    }
    
}
