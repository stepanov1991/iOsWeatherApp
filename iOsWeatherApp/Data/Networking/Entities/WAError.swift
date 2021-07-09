//
//  WAError.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation

enum WAError: Error {
    case undefined
    case networkingError(URLError.Code)
}
