//
//  WeatherView.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

    }
    
    let weatherForecastLoaction:UILabel = {
        let label = UILabel()
        label.text = "Weather Forecast for"
        return label
    }()
    
    let enterZipCodeLabel:UILabel = {
        let label = UILabel()
        label.text = "Enter a Zip Code"
        return label
    }()
    
    let zipCodeTextField:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Zip Code"
        return textfield
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
