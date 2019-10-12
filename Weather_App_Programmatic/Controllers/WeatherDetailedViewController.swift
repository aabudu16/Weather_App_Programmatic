//
//  WeatherDetailedViewController.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WeatherDetailedViewController: UIViewController {

    var weatherDetail:DailyDatum!{
        didSet{
//            detailDateLabel.text = weatherDetail.time.description
//            print(detailDateLabel.text as Any)
        }
    }
    
    var currentLocationDetail:WeatherModel!{
        didSet{
        
        }
    }
    
    let weatherForcastLabel:UILabel = {
       let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    let currentWeatherLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    let highLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    let lowLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    let sunriseLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    let sunsetLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    let windspeedLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    let percipitationLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.title = "Forecast"
view.backgroundColor = .white
        
    }
    

}
