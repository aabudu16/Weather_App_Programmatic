//
//  WeathersCollectionViewCell.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WeathersCollectionViewCell: UICollectionViewCell {
        override init(frame: CGRect) {
        super.init(frame:frame)
        setUpDateLabelConstraints()
        setUpStackViewConstraints()
    }
    
    let dateLabel:UILabel = {
       let label = UILabel(color: .black, font: .italicSystemFont(ofSize: 20))
        return label
    }()
    
    let highLabel:UILabel = {
       let label = UILabel(color: .black, font: .italicSystemFont(ofSize: 20))
        return label
    }()
    
    let lowLabel:UILabel = {
        let label = UILabel(color: .black, font: .italicSystemFont(ofSize: 20))
        return label
    }()
    
    let weatherImage:UIImageView = {
       let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    func setUpDateLabelConstraints() {
        self.contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    lazy var temperatureStackView:UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [highLabel,lowLabel])
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
    }()
    
    lazy var weatherImageAndTemperatureStackView:UIStackView = {
            let stacky = UIStackView(arrangedSubviews: [weatherImage,temperatureStackView])
            stacky.axis = .vertical
            stacky.distribution = .fillEqually
            stacky.alignment = .fill
            stacky.spacing = 10
            stacky.translatesAutoresizingMaskIntoConstraints = false
            return stacky
    }()
    
    

    func setUpStackViewConstraints() {
        self.contentView.addSubview(weatherImageAndTemperatureStackView)
        weatherImageAndTemperatureStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        weatherImageAndTemperatureStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        weatherImageAndTemperatureStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        weatherImageAndTemperatureStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
