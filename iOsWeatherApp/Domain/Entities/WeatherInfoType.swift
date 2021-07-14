//
//  WeatherInfo.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation

enum WeatherInfoType {
    
    case sunrise(String)
    case sunset(String)
    case rainChance(String)
    case humidity(String)
    case wind(String)
    case feelslike(String)
    case precipitationInMM(String)
    case pressure(String)
    case visibility(String)
    case uv(String)
    
    func title() -> String {
        switch self {
        case .sunrise:                return "SUNRISE"
        case .sunset:                 return "SUNSET"
        case .rainChance:             return "CHANCE OF RAIN"
        case .humidity:               return "HUMIDITY"
        case .wind:                   return "WIND"
        case .feelslike:              return "FEELS LIKE"
        case .precipitationInMM:      return "PRECIPITATION"
        case .pressure:               return "PRESSURE"
        case .visibility:             return "VISIBILITY"
        case .uv:                     return "UV INDEX"
        }
    }
    
    func value() -> String {
        switch self {
        case .sunrise(let value):                return value
        case .sunset(let value):                 return value
        case .rainChance(let value):             return value
        case .humidity(let value):               return value
        case .wind(let value):                   return value
        case .feelslike(let value):              return value
        case .precipitationInMM(let value):      return value
        case .pressure(let value):               return value
        case .visibility(let value):             return value
        case .uv(let value):                     return value
        }
    }
}
