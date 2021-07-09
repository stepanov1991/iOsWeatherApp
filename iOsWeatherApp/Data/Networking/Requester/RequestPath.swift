//
//  RequestPath.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation


enum RequestPath {
    case realtime(String)
    
    var path:String {
        switch self {
        case .realtime :  return "current.json"
        }
    }
    
    var version:String {
        switch self {
        case .realtime:   return "v1"
        }
    }
    
    var value:String {
        switch self {
        case .realtime(let city):
            var urlComponents    = URLComponents()
            urlComponents.host   = "\(NetworkConfiguration.baseURL)/\(version)/"
            urlComponents.path   = path
            let queryItems:[URLQueryItem] = [
                URLQueryItem(name: "key", value: NetworkConfiguration.weatherAPIKey),
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "aqi", value: "yes")
            ]
            urlComponents.queryItems = queryItems
            return urlComponents.url!.absoluteString
        }
    }
}
