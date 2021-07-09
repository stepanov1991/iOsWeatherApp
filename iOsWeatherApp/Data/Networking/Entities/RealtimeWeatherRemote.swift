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
    var condition : [Condition]?
    var windKilometres : Float?
    var windDirection : String?
    var pressure : Float?
    var precipitation : Float?
    var feelsLike : Float?
    var visibility : Float?
    /*"last_updated_epoch": 1625833800,
            "last_updated": "2021-07-09 13:30",
            "temp_c": 23.0,
            "temp_f": 73.4,
            "is_day": 1,
            "condition": {
                "text": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                "code": 1003
            },
            "wind_mph": 9.4,
            "wind_kph": 15.1,
            "wind_degree": 270,
            "wind_dir": "W",
            "pressure_mb": 1021.0,
            "pressure_in": 30.6,
            "precip_mm": 0.0,
            "precip_in": 0.0,
            "humidity": 57,
            "cloud": 50,
            "feelslike_c": 24.9,
            "feelslike_f": 76.8,
            "vis_km": 10.0,
            "vis_miles": 6.0,
            "uv": 5.0,
            "gust_mph": 7.4,
            "gust_kph": 11.9
        }*/
    
    struct Condition : Codable {
        var text : String?
    }
    
    enum CodingKeys:String, CodingKey {
        case tempCelsius = "temp_c"
        case condition
        case windKilometres = "wind_mph"
        case windDirection = "wind_dir"
        case pressure = "pressure_mb"
        case precipitation = "precip_mm"
        case feelsLike = "feelslike_c"
        case visibility = "vis_km"
    }
}
