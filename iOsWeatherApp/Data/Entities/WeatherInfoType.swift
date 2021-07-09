//
//  WeatherInfo.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation

enum WeatherInfoType {
    case sunRise(String)
    case sunSet(String)
    case wind(String)
    case feelslike(String)
    case precipitation(String)
    
    func title() -> String {
        switch self {
        case .sunRise:       return "СХІД СОНЦЯ"
        case .sunSet:        return "ЗАХДІ СОНЦЯ"
        case .wind:          return "ВІТЕР"
        case .feelslike:     return "ВІДЧУВАЄТЬСЯ ЯК"
        case .precipitation: return "ОПАДИ"
        }
    }
    
    func value() -> String {
        switch self {
        case .sunRise(let value):         return value
        case .sunSet(let value):          return value
        case .wind(let value):            return value
        case .feelslike(let value):       return value
        case .precipitation(let value):   return value
        }
    }
}
