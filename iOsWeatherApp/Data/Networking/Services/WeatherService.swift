//
//  WeatherService.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation



final class WeatherService: ServiceProtocol {
    
    static func realite(city:String, complition:@escaping ((RealtimeWeatherRemote?,Error?)->())) {
        let url               = URL(string:RequestPath.realtime(city).value)!
        var urlRequest        = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = RequesterManager
            .sharedSession
            .dataTask(with: urlRequest) { data, response, error in
                // 1) check reposne.statusCode -> 200...299
                // else show or pass the error to the callback
                // 2) log ( URL, StatusCode, data as String)
                // 3) Parse Data to RealimeWeatherModel
                
                guard let response = response as? HTTPURLResponse else {
                    complition(nil , WAError.networkingError(URLError.badServerResponse))
                    return
                }
                
                guard (200...299).contains(response.statusCode) else {
                    complition(nil , WAError.networkingError(URLError.badServerResponse))
                    return
                }
                
                log(urlRequest, response, data)
                
                if let entity = entity(ofType: RealtimeWeatherRemote.self, from: data) {
                    complition(entity, nil)
//                    let realtimeWeather = WeatherModel(city: (entity.location?.name)!, conditionText: (entity.current?.condition.text)!, temp: (entity.current?.tempCelsius)!, temp_min: 19, temp_max: 29)
                }
            }
        task.resume()
    }
    
}
