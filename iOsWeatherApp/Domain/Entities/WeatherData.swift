//
//  WeatherData.swift
//  iOsWeatherApp
//
//  Created by user on 09.07.2021.
//

import UIKit

struct WeatherData: Codable {
    var city: String?
    var temp: Int?
    var condition: String?
    var precipitationInPercent: Double?
    var precipitationInMM: Double?
    var visibility: Int?
    var windKilometres: Double?
    var pressure: Int?
    var feelsLike: Int?
    var humidity: Int?
    var uv: Int?
    
    
    static func from(remote:RealtimeWeatherRemote) -> WeatherData {
        return WeatherData(city: remote.location?.name,
                           temp: remote.current?.tempCelsius,
                           condition: remote.current?.condition.text,
                           precipitationInPercent: remote.current?.precipitationInPercent,
                           precipitationInMM: remote.current?.precipitationInMM,
                           visibility: remote.current?.visibility,
                           windKilometres: remote.current?.windKilometres,
                           pressure: remote.current?.pressure,
                           feelsLike: remote.current?.feelsLike, humidity: remote.current?.humidity, uv: remote.current?.uv)
    }
}
