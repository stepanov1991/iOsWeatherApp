//
//  NetworkingConfiguration.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation

enum NetworkingEnvironment {
    case stage
    case production
}

struct NetworkConfiguration {
    
    private static var environment:NetworkingEnvironment = .production
    
    public static var baseURL:String {
        switch environment {
        case .production: return "api.weatherapi.com"
        case .stage:      return ""
        }
    }
    
    public static  var weatherAPIKey:String {
        switch environment {
        case .production: return "04caf053efeb41d3abe73156210907"
        case .stage:      return ""
        }
    }
}
