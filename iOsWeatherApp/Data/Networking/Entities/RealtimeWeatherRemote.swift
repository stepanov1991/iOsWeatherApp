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
    var condition: ConditionRemote?
}

struct CurrentWeatherRemote: Codable {
    var tempCelsius: Int?
    var condition: ConditionRemote
    var windKilometres: Double?
    var windDirection: String?
    var pressure: Int?
    var precipitationInPercent: Double?
    var precipitationInMM: Double?
    var feelsLike: Double?
    var visibility: Int?
    var humidity : Int?
    var uv : Int?

          
    enum CodingKeys:String, CodingKey {
        case tempCelsius             = "temp_c"
        case condition
        case windKilometres          = "wind_mph"
        case windDirection           = "wind_dir"
        case pressure                = "pressure_mb"
        case precipitationInPercent  = "precip_in"
        case precipitationInMM       = "precip_mm"
        case feelsLike               = "feelslike_c"
        case visibility              = "vis_km"
        case humidity
        case uv
    }
}


