//
//  RealtimeWeather.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation

struct RealtimeWeatherRemote: Codable {
    var location: LocationRemote?
    var current: CurrentWeatherRemote?
}

struct CurrentWeatherRemote: Codable {
    var tempCelsius : Float?
    var condition : Condition
    var windKilometres : Float?
    var windDirection : String?
    var pressure : Float?
    var precipitation : Float?
    var feelsLike : Float?
    var visibility : Float?
          
    enum CodingKeys:String, CodingKey {
        case tempCelsius    = "temp_c"
        case condition
        case windKilometres = "wind_mph"
        case windDirection  = "wind_dir"
        case pressure       = "pressure_mb"
        case precipitation  = "precip_mm"
        case feelsLike      = "feelslike_c"
        case visibility     = "vis_km"
    }
}

struct Condition : Codable {
    var text : String?
}
