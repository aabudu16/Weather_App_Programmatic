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
            detailDateLabel.text = currentLocationDetail.timezone
            print(detailDateLabel.text)
        }
    }
    
    let detailDateLabel:UILabel = {
       let label = UILabel(color: .black, font: .systemFont(ofSize: 15))
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
view.backgroundColor = .white
        view.addSubview(detailDateLabel)
    }
    

}
