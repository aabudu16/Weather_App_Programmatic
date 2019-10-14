//
//  WeatherDetailedViewController.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WeatherDetailedViewController: UIViewController {
    
    var currentLocationDetail:WeatherModel!{
        didSet{
            getImageURL()
           // getImage()
        }
    }
    
    var weatherDetail:DailyDatum!{
        didSet{
            setupDetailedVC()
        }
    }
    
    var currentLocationImage:String!
    
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
    
    let favoriteButton:UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Favorite"
        button.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return button
    }()
    let cityImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Forecast"
        view.backgroundColor = .white
        
    }
    
    private func getImageURL(){
        
        let location = currentLocationDetail.timezone.components(separatedBy: "/")[1]
        PhotoAPIClient.shared.getData(searchTerm: location) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let photos):
                DispatchQueue.main.async {
                    self.currentLocationImage = photos[.random(in: 0...10)].largeImageURL
                    print(self.currentLocationImage)
                   
                }
            }
        }
    }
    
    @objc func handleFavorite(){
        let myFav = FavoritePhotosModel(imageURL: currentLocationImage )
        DispatchQueue.global(qos: .utility).async {
            try? WeatherPhotoPersistenceHelper.manager.save(newPhoto: myFav)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func getImage(){
        ImageHelper.shared.getImage(urlStr: currentLocationImage) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.cityImageView.image = image
                    print(self.cityImageView.image)
                }
            }
        }
    }
    
    private func setupDetailedVC(){
        weatherForcastLabel.text = "Weather Forecast for \(weatherDetail.getDateFromTime(time: weatherDetail.time))"
        
        highLabel.text = weatherDetail.returnHighTemperatureInF(temp: weatherDetail.temperatureHigh)
        lowLabel.text = weatherDetail.returnLowTemperatureInF(temp: weatherDetail.temperatureLow)
        sunriseLabel.text = "Sunrise: \(weatherDetail.getDateFromTime(time: weatherDetail.sunriseTime))"
        sunsetLabel.text = "Sunset: \(weatherDetail.getDateFromTime(time: weatherDetail.sunsetTime))"
        windspeedLabel.text = "Windspeed: \(weatherDetail.windSpeed) MPH"
        percipitationLabel.text = "percipitation: \(weatherDetail.precipIntensity)"
        
    }
    
}

