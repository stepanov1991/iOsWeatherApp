//
//  LocationManager.swift
//  iOsWeatherApp
//
//  Created by user on 14.07.2021.
//

import Foundation


extension Notification.Name {
    static let locationArrayDidChange = Notification.Name("locationArrayDidChange")
}

struct LocationManager {
    private static var _locationArray = ["London", "Paris", "Madrid", "Kiev", "Lviv"]
    static var locationArray:[String] { _locationArray }
    
    static func add(location:String) {
        _locationArray.append(location)
        NotificationCenter.default.post(name: .locationArrayDidChange, object: nil)
    }
    
    static func remove(location:String) {
        _locationArray.removeAll { $0 == location }
        NotificationCenter.default.post(name: .locationArrayDidChange, object: nil)
    }
}
