//
//  ViewController.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    enum Identifier:String{
        case weathersCollectionViewCell
        case weatherCell
    }
    
    var weatherLocation:WeatherModel!{
        didSet{
            weatherForecastLoaction.text = weatherLocation.timezone.components(separatedBy: "/")[1].replacingOccurrences(of: "_", with: " ")
        }
    }
    var weather = [DailyDatum](){
        didSet{
            DispatchQueue.main.async {
                self.userCollectionView.reloadData()
            }
        }
    }
    
    var coordinates = String(){
        didSet{
            self.userCollectionView.reloadData()
        }
    }
    
    let weatherForecastLoaction:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 20))
        label.text = "Weather Forecast for ..."
        return label
    }()
    
    let enterZipCodeLabel:UILabel = {
        let label = UILabel(color: .black, font: .systemFont(ofSize: 20))
        label.text = "Enter a Zip Code"
        return label
    }()
    
    let zipCodeTextField:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Zip Code"
        textfield.textAlignment = .center
        return textfield
    }()
    
    var layout = UICollectionViewFlowLayout.init()
    lazy var userCollectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register(WeathersCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.weathersCollectionViewCell.rawValue )
        collectionView.backgroundColor = .white
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 600
        layout.itemSize = CGSize(width: 200, height: 200)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        zipCodeTextField.delegate = self
        setupView()
        createConstraints()
    }
    
    func getData(zipCode:String){
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { (result) in
            switch result{
            case .failure( _):
                let alert = UIAlertController(title: "Sorry", message: "Please enter a valid zip code", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            case .success(let lat, let long):
                self.coordinates = "\(lat),\(long)"
                
                WeatherAPIClient.shared.fetchData(zipCode: self.coordinates) { (result) in
                    switch result{
                    case .failure(let error):
                        let alert = UIAlertController(title: "Sorry", message: "There was a problem with you search \(error)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    case .success(let weather):
                        self.weather = weather.daily.data
                        self.weatherLocation = weather
                        
                    }
                }
            }
        }
    }
    
    private func setupView(){
        self.view.addSubview(userCollectionView)
        self.view.addSubview(weatherForecastLoaction)
        self.view.addSubview(enterZipCodeLabel)
        self.view.addSubview(zipCodeTextField)
    }
    
    private func createConstraints() {
        
        weatherForecastLoaction.translatesAutoresizingMaskIntoConstraints = false
        weatherForecastLoaction.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherForecastLoaction.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weatherForecastLoaction.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        weatherForecastLoaction.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        userCollectionView.translatesAutoresizingMaskIntoConstraints = false
        userCollectionView.topAnchor.constraint(equalTo: weatherForecastLoaction.bottomAnchor).isActive = true
        userCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        userCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        zipCodeTextField.textColor = .red
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        zipCodeTextField.topAnchor.constraint(equalTo: userCollectionView.bottomAnchor, constant: 10).isActive = true
        zipCodeTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        zipCodeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        zipCodeTextField.widthAnchor.constraint(equalToConstant: 120).isActive = true
        zipCodeTextField.becomeFirstResponder()
        
        enterZipCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        enterZipCodeLabel.topAnchor.constraint(equalTo: zipCodeTextField.bottomAnchor, constant: 10).isActive = true
        enterZipCodeLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        enterZipCodeLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        enterZipCodeLabel.text = "Enter a ZipCode"
    }
}
extension WeatherViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weatherDetailedVC = WeatherDetailedViewController()
        
        
        let info = weather[indexPath.item]
        let currentWeatherLocation = [weatherLocation]
       weatherDetailedVC.weatherDetail = info
        weatherDetailedVC.currentLocationDetail = currentWeatherLocation[0]
       
        self.navigationController?.pushViewController(weatherDetailedVC, animated: true)
    }
}
extension WeatherViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.weathersCollectionViewCell.rawValue, for: indexPath) as? WeathersCollectionViewCell else {return UICollectionViewCell()}
        
        let info = weather[indexPath.item]
        CustomLayer.shared.createCustomlayer(layer: cell.layer)
        cell.dateLabel.text = info.getDateFromTime(time: info.time)
        cell.highLabel.text = info.returnHighTemperatureInF(temp: info.temperatureHigh)
        cell.lowLabel.text = info.returnLowTemperatureInF(temp: info.temperatureLow)
        cell.weatherImage.image = info.returnPictureBasedOnIcon(icon: info.icon)
        
        return cell
    }
    
    
    
}
extension WeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let zip = textField.text{
            getData(zipCode: zip)
        }
        return true
    }
}
