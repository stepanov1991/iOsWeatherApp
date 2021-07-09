//
//  RequesterManager.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import Foundation

struct RequesterManager {
    public static let sharedSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.httpAdditionalHeaders     = defaultHeaders
        let shared = URLSession(configuration: configuration)
        return shared
    }()
    
    private static var defaultHeaders:[AnyHashable:Any] = {
        var headers: [AnyHashable:Any] = [:]
        headers["Accept-Encoding"]     =  defaultAcceptEncodingValue
        headers["Accept-Language"]     =  defaultAcceptLanguageValue
        headers["User-Agent"]          =  defaultUserAgentValue
        return headers
    }()
}

internal extension RequesterManager {

    private static var defaultAcceptEncodingValue: String = {
        let encodings: [String]
        if #available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *) {
            encodings = ["br", "gzip", "deflate"]
        } else {
            encodings = ["gzip", "deflate"]
        }
        return encodings.qualityEncoded()
    }()
    
    private static var defaultAcceptLanguageValue: String = {
        return Locale.preferredLanguages.prefix(6).qualityEncoded()
    }()
    
    private static var defaultUserAgentValue: String =  {
        let info = Bundle.main.infoDictionary
        let executable = (info?[kCFBundleExecutableKey as String] as? String) ??
            (ProcessInfo.processInfo.arguments.first?.split(separator: "/").last.map(String.init)) ??
            "Unknown"
        let bundle = info?[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
        let appVersion = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let appBuild = info?[kCFBundleVersionKey as String] as? String ?? "Unknown"

        let osNameVersion: String = {
            let version = ProcessInfo.processInfo.operatingSystemVersion
            let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
            let osName: String = {
                #if os(iOS)
                #if targetEnvironment(macCatalyst)
                return "macOS(Catalyst)"
                #else
                return "iOS"
                #endif
                #elseif os(watchOS)
                return "watchOS"
                #elseif os(tvOS)
                return "tvOS"
                #elseif os(macOS)
                return "macOS"
                #elseif os(Linux)
                return "Linux"
                #elseif os(Windows)
                return "Windows"
                #else
                return "Unknown"
                #endif
            }()

            return "\(osName) \(versionString)"
        }()

        return "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion))"
    }()
}
