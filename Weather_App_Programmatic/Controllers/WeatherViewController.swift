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
        case weatherCollectionViewCell
        case weatherCell
        
    }
    var weatherView:WeatherView!
    var weather = [DailyDatum](){
        didSet{
            DispatchQueue.main.async {
                self.userCollectionView.reloadData()
            }
        }
    }
    var layout = UICollectionViewFlowLayout.init()
    lazy var userCollectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        layout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.weatherCollectionViewCell.rawValue )
        return collectionView
    }()
    
    private var searchWord:String?{
        didSet{
            userCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.addSubview(userCollectionView)
        let nib = UINib(nibName:Identifier.weatherCollectionViewCell.rawValue, bundle: nil)
        userCollectionView.register(nib, forCellWithReuseIdentifier: Identifier.weatherCell.rawValue)
        getData()
    }

    func getData(){
        WeatherAPIClient.shared.fetchData(zipCode: searchWord ?? "") { (result) in
            switch result{
            case .failure(let error):
                let alert = UIAlertController(title: "Sorry", message: "There was a problem with you search \(error)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            case .success(let weather):
                self.weather = weather
                
                
            }
        }
    }

}
extension WeatherViewController: UICollectionViewDelegate{}
extension WeatherViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}

