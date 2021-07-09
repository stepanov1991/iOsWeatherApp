//
//  ServiceProtocol.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation


protocol ServiceProtocol {
    static func entity<T: Codable>(ofType type: T.Type, from data: Data?)                       -> T?
    static func log(_ request:URLRequest, _ response: HTTPURLResponse, _ responseData:Data?)
}

extension ServiceProtocol {
    static func entity<T: Codable>(ofType type: T.Type, from data: Data?) -> T? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        var entity:T? = nil
        do {
            entity = try decoder.decode(type, from: data)
        }
        catch(let exp) {
            print("\(String(describing: self))::Parse Exeption:: \(String(describing:exp))")
        }
        return entity
    }
    
    static func log(_ request:URLRequest, _ response: HTTPURLResponse, _ responseData:Data?) {
        
        print("[-------------------Start----------------------]\n")
        print("[Request URL]: \(String(describing: request.url?.absoluteString))\n")
        print("[HTTP method]: \(request.httpMethod ?? "<Unknown>")\n")
        print("[Staus code]:  \(String(describing: response.statusCode))\n")
        
        if let responseData = responseData,
           let string = String(data: responseData, encoding: .utf8),
           let data = string.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                let jsonString = String(decoding: jsonData, as: UTF8.self)
                print("[Response]: \(jsonString))\n")
            }
        print("[--------------------End---------------------]\n")
    }
}
