//
//  Location.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation

struct LocationRemote: Codable {
    var name:String?
    var region:String?
    var country:String?
    var latitude:Double?
    var longitude:Double?
    var timeZoneId:String?
    var localtimeEpoch:Int?
    var localtime:String?
    
    enum CodingKeys:String, CodingKey {
        case name
        case region
        case country
        case latitude       = "lat"
        case longitude      = "lon"
        case timeZoneId     = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
