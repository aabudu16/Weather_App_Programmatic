//
//  WeatherDetailedViewController.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WeatherDetailedViewController: UIViewController {
    
    var currentLocationDetail:String!{
        didSet{
            getImageURL()
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
    
    let favoriteButton:UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleFavorite))
        return button
    }()
    let cityImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    lazy var stackViewDetails:UIStackView = {
        return returnStackViewDetails()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Forecast"
        view.backgroundColor = .white
        addSubViews()
        setUpLocationLabelConstraints()
        setUpImageViewConstraints()
        setUpSummaryLabel()
        setUpStackViewDetails()
        
    }
    
    private func getImageURL(){
    
        PhotoAPIClient.shared.getData(searchTerm: currentLocationDetail) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let photos):
                DispatchQueue.main.async {
                    self.currentLocationImage = photos[0].largeImageURL
                   print(self.currentLocationImage)
                   
                }
            }
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
                   // print(self.cityImageView.image)
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
    
    private func setupDetailedVC(){
        weatherForcastLabel.text = "Weather Forecast for \(weatherDetail.getDateFromTime(time: weatherDetail.time))"
        
        highLabel.text = weatherDetail.returnHighTemperatureInF(temp: weatherDetail.temperatureHigh)
        lowLabel.text = weatherDetail.returnLowTemperatureInF(temp: weatherDetail.temperatureLow)
        sunriseLabel.text = "Sunrise: \(weatherDetail.getDateFromTime(time: weatherDetail.sunriseTime))"
        sunsetLabel.text = "Sunset: \(weatherDetail.getDateFromTime(time: weatherDetail.sunsetTime))"
        windspeedLabel.text = "Windspeed: \(weatherDetail.windSpeed) MPH"
        percipitationLabel.text = "percipitation: \(weatherDetail.precipIntensity)"
        currentWeatherLabel.text = weatherDetail.summary
        
    }
    
    func addSubViews() {
        view.addSubview(weatherForcastLabel)
        view.addSubview(cityImageView)
        view.addSubview(currentWeatherLabel)
        view.addSubview(stackViewDetails)
       // view.addSubview(favoriteButton)
        navigationItem.rightBarButtonItem = favoriteButton
       // view.addSubview(favoriteButton)
    }
    func returnStackViewDetails() -> UIStackView {
        let stacky = UIStackView(arrangedSubviews: [highLabel,lowLabel,sunriseLabel,sunsetLabel,windspeedLabel,percipitationLabel])
        stacky.axis = .vertical
        stacky.distribution = .fillEqually
        stacky.alignment = .fill
        stacky.spacing = 10
        stacky.translatesAutoresizingMaskIntoConstraints = false
        return stacky
    }
    func setUpLocationLabelConstraints() {
        weatherForcastLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherForcastLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        weatherForcastLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weatherForcastLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setUpImageViewConstraints() {
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        cityImageView.topAnchor.constraint(equalTo: weatherForcastLabel.bottomAnchor, constant: 20).isActive = true
        cityImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cityImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setUpSummaryLabel() {
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherLabel.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 5).isActive = true
        currentWeatherLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        currentWeatherLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setUpStackViewDetails() {
        stackViewDetails.translatesAutoresizingMaskIntoConstraints = false
        stackViewDetails.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor, constant: 10).isActive = true
        stackViewDetails.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        stackViewDetails.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackViewDetails.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
    
    

    

    
}

