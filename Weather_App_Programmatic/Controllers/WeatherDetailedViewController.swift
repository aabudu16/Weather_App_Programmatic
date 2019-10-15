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
    
    var currentLocationImage:String!{
        didSet{
            getImage()
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
    
    let cityImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    lazy var stackViewDetails:UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [highLabel,lowLabel,sunriseLabel,sunsetLabel,windspeedLabel,percipitationLabel])
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
    }()
    
    private var saveButton = UIBarButtonItem()
    
    
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
                    self.currentLocationImage = photos[.random(in: 0...10)].largeImageURL
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
                }
            }
        }
    }
    
    @objc func handleFavorite(){
        
        let myFav = FavoritePhotosModel(imageURL: currentLocationImage )
        DispatchQueue.global(qos: .utility).async {
            try? WeatherPhotoPersistenceHelper.manager.save(newPhoto: myFav)
        }
        self.dismiss(animated: true, completion: nil)
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
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleFavorite))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setUpLocationLabelConstraints() {
    weatherForcastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        weatherForcastLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
        weatherForcastLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        weatherForcastLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    func setUpImageViewConstraints() {
        
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        cityImageView.topAnchor.constraint(equalTo: weatherForcastLabel.bottomAnchor, constant: 20),
        cityImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        cityImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    func setUpSummaryLabel() {
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        currentWeatherLabel.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 5),
        currentWeatherLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        currentWeatherLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    func setUpStackViewDetails() {
        stackViewDetails.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewDetails.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor, constant: 10),
            stackViewDetails.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackViewDetails.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        stackViewDetails.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
    ])
    }
    
    
    
    

    

    
}

