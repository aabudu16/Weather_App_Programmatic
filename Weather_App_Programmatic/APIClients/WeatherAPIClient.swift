//
//  WeatherAPIClient.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct WeatherAPIClient {
    static let shared = WeatherAPIClient()
    
    let secretKey = Secret.key
    
    
    func fetchData(zipCode:String, completionHandler: @escaping (Result<[DailyDatum],AppError>)->()){
        
        let urlString = "https://api.darksky.net/forecast/\(secretKey)/\(zipCode)"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                
                do{
                    let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completionHandler(.success(weatherData.daily.data))
                }catch{
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
        
    }
}
