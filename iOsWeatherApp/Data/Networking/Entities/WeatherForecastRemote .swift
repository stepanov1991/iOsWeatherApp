//
//  WeatherForecastRemote .swift
//  iOsWeatherApp
//
//  Created by user on 12.07.2021.
//

import Foundation

struct WeatherForecastRemote: Codable {
    var location: LocationRemote?
    var current: CurrentWeatherRemote?
    var forecast: ForecastRemote?
}

struct ForecastRemote: Codable {
    var forecastday: [ForecastdayRemote]?
}

struct ForecastdayRemote: Codable {
    var date: String?
    var day: DayRemote?
    var astro: AstroRemote?
    var hour: [HourRemote]?
}

struct DayRemote: Codable {
    var maxTemp: Double?
    var minTemp: Double?
    var tempC: Double?
    var condition: ConditionRemote?
    var rainChance: String
    
    enum CodingKeys: String, CodingKey {
        case maxTemp = "maxtemp_c"
        case minTemp = "mintemp_c"
        case tempC   = "avgtemp_c"
        case condition
        case rainChance = "daily_chance_of_rain"
    }
}

struct AstroRemote: Codable {
    var sunrise: String?
    var sunset: String?
}

struct HourRemote: Codable {
    var time: String?
    var temp: Double?
    var condition: ConditionRemote?
    
    enum CodingKeys: String, CodingKey {
        case time
        case temp = "temp_c"
        case condition
    }
}



