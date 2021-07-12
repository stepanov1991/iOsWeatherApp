//
//  WeatherData.swift
//  iOsWeatherApp
//
//  Created by user on 09.07.2021.
//

import UIKit

struct WeatherData: Codable {
    
    
    static func from(remote:RealtimeWeatherRemote) -> WeatherData {
        var wd = WeatherData()
        // wd.temp = remote.temp
        return wd
    }
}
