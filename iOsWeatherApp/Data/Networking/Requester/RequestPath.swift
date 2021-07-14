//
//  RequestPath.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation


enum RequestPath {
    case realtime(String)
    case forecast(String)
    
    var path:String {
        switch self {
        case .realtime:  return "current.json"
        case .forecast:  return "forecast.json"
        }
    }
    
    var version:String {
        switch self {
        case .realtime:   return "v1"
        case .forecast:   return "v1"
        }
    }
    
    var value:URL {
        switch self {
        case .realtime(let city):
            var urlComponents    = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host   = "\(NetworkConfiguration.baseURL)"
            urlComponents.path   = "/\(version)/\(path)"
            let queryItems:[URLQueryItem] = [
                URLQueryItem(name: "key", value: NetworkConfiguration.weatherAPIKey),
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "aqi", value: "yes")
            ]
            urlComponents.queryItems = queryItems
            return urlComponents.url!
            
        case .forecast(let city):
            var urlComponents    = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host   = "\(NetworkConfiguration.baseURL)"
            urlComponents.path   = "/\(version)/\(path)"
            let queryItems:[URLQueryItem] = [
                URLQueryItem(name: "key", value: NetworkConfiguration.weatherAPIKey),
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "aqi", value: "yes"),
                URLQueryItem(name: "days", value: "7")
            ]
            urlComponents.queryItems = queryItems
            return urlComponents.url!
        }
    }
}

