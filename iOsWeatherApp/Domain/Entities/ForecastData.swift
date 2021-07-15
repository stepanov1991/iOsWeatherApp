//
//  ForecastData.swift
//  iOsWeatherApp
//
//  Created by user on 13.07.2021.
//

import Foundation

struct ForecastData {
    let name : String?
    let tempC : Int?
    let conditionText : String?
    let windKph: Double?
    let pressureMB: Int?
    let precipMm, precipIn: Double?
    let humidity:Int?
    var feelslikeC: Double?
    let visKM, uv: Int?
    let forecastDay: [ForecastDay]?
    let sunrice: String?
    let sunset: String?
    let rainChance: String?
    let localtime: String?
    
    func toWeatherInfoArray() -> [WeatherInfoType]{
        var array = [WeatherInfoType]()
        if let sunrice = self.sunrice {
            array.append(.sunrise(sunrice))
        }
        if let sunset = self.sunset {
            array.append(.sunset(sunset))
        }
        if let rainChance = self.rainChance {
            array.append(.rainChance(rainChance + "%"))
        }
        if let humidity = self.humidity {
            array.append(.humidity(String(humidity) + "%"))
        }
        if let windKph = self.windKph {
            array.append(.wind(String(windKph) + " km/ph"))
        }
        if let feelslikeC = self.feelslikeC {
            array.append(.feelslike(String(feelslikeC) + "°"))
        }
        if let precipMm = self.precipMm {
            array.append(.precipitationInMM(String(precipMm * 10)  + " cm"))
        }
        if let pressureMB = self.pressureMB {
            array.append(.pressure(String(pressureMB) + " hPa"))
        }
        if let visKM = self.visKM {
            array.append(.visibility(String(visKM) + " km"))
        }
        if let uv = self.uv {
            array.append(.uv(String(uv)))
        }
        
        return array
    }
    
    
    
    static func from(_ remote:WeatherForecastRemote) -> ForecastData {
        return ForecastData(name: remote.location?.name,
                            tempC: remote.current?.tempCelsius,
                            conditionText: remote.current?.condition.text,
                            windKph: remote.current?.windKilometres,
                            pressureMB: remote.current?.pressure,
                            precipMm: remote.current?.precipitationInMM,
                            precipIn: remote.current?.precipitationInPercent,
                            humidity: remote.current?.humidity,
                            feelslikeC: remote.current?.feelsLike,
                            visKM: remote.current?.visibility,
                            uv: remote.current?.uv,
                            forecastDay: remote.forecast?.forecastday?.map(ForecastDay.from),
                            sunrice: remote.forecast?.forecastday?[0].astro?.sunrise,
                            sunset: remote.forecast?.forecastday?[0].astro?.sunset,
                            rainChance: remote.forecast?.forecastday?[0].day?.rainChance, localtime: remote.location?.localtime)
}
}
struct ForecastDay {
    let hour: [Hour]?
    let day: Day?
    let date: String?
    let astro: Astro?
    
    static func from(_ remote : ForecastdayRemote) -> ForecastDay {
        ForecastDay(hour: remote.hour?.map(Hour.from),
                    day: Day.from(remote.day),
                    date: remote.date,
                    astro: Astro.from(remote.astro))
    }
    
}

struct Day {
    let temp : Double?
    let maxTempC: Double?
    let minTempC: Double?
    let rainChance: String?
    let condition: Condition?

    
    static func from(_ remore: DayRemote?) -> Day {
        return Day(temp: remore?.tempC,
                   maxTempC: remore?.maxTemp,
                   minTempC: remore?.minTemp,
                   rainChance: remore?.rainChance,
                   condition: Condition.from(remore?.condition))
    }
}

struct Hour {
    let time: String?
    let tempC: Double?
    let condition: Condition?
    
    static func from(_ remote : HourRemote) -> Hour {
        Hour(time: remote.time,
             tempC: remote.temp,
             condition: Condition.from(remote.condition))
    }
    
}

struct Condition {
    let text: String?
    let icon: String?
    let code: Int?
    
    static func from(_ remote: ConditionRemote?) -> Condition {
        Condition(text: remote?.text,
                  icon: remote?.icon,
                  code: remote?.code)
    }
}

struct Astro {
    let sunrise: String?
    let sunset: String?
    
    static func from(_ remote: AstroRemote?) -> Astro {
        return Astro(sunrise: remote?.sunrise,
                     sunset: remote?.sunset)
    }
}
