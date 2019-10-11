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
}
enum Icon: String, Codable {
    case cloudy = "cloudy"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
}
// MARK: - Daily
struct Daily: Codable {
    let summary: String
    let icon: Icon
    let data: [DailyDatum]
}
// MARK: - DailyDatum
struct DailyDatum: Codable {
    let time: Int
    let summary, icon: String
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
            return UIImage(named: "pcloudywn")!
        default:
            return UIImage(named: "Placeholder")!
        }
    }
}
