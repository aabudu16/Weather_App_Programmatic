//
//  WeatherModel.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit
// MARK: - WeatherModel
struct WeatherModel: Codable {
    let timezone: String
    let daily: Daily
    
    static func getWeatherDataTest(from data:Data) -> [DailyDatum] {
        do {
            let newWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
            return newWeather.daily.data
        } catch let error {
            print(error)
            return []
        }
    }
}
enum Icon: String, Codable {
    case cloudy = "cloudy"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
}
// MARK: - Daily
struct Daily: Codable {
    let summary: String
    let icon: Icon?
    let data: [DailyDatum]
}
// MARK: - DailyDatum
struct DailyDatum: Codable {
    let time: Int
    let summary, icon: String?
    let sunriseTime, sunsetTime: Int
    let precipIntensity:Double
    let precipProbability: Double
    let precipType: Icon?
    let temperatureHigh: Double
    let temperatureLow: Double
    let windSpeed: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    
    
    
    func getDateFromTime(time:Int) -> String {
        let date = NSDate(timeIntervalSince1970: Double(time))
        return date.description.components(separatedBy: " ")[0]
    }
    func returnHighTemperatureInF(temp:Double) -> String {
        return "High: \(temp)°F"
    }
    func returnLowTemperatureInF(temp:Double) -> String {
        return "Low: \(temp)°F"
    }
    func returnPictureBasedOnIcon(icon:String) -> UIImage {
        switch icon {
        case "rain":
            return UIImage(named: "rain")!
        case "cloudy":
            return UIImage(named: "cloudy")!
        case "partly-cloudy-night":
            return UIImage(named: "pcloudyn")!
        case "clear-day":
            return UIImage(named: "clear")!
        case "clear-night":
            return UIImage(named:"clearn")!
        case "partly-cloudy-day":
            return UIImage(named:"pcloudy" )!
        case "snow":
            return UIImage(named: "snow")!
        case "sleet":
            return UIImage(named: "sleet")!
        case "wind":
            return UIImage(named: "wind")!
        case "fog":
            return UIImage(named:"fog")!
        default:
            return UIImage(named: "image")!
        }
    }
    
}
