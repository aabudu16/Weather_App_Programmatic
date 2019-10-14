//
//  FavoriteViewController.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private enum Identifier:String{
        case favoriteCollectionViewCell
        case favoriteCell
    }
    
    var favoriteImage = [FavoritePhotosModel](){
        didSet{
            favoriteCollectionView.reloadData()
        }
    }
    
    var layout = UICollectionViewFlowLayout.init()
    lazy var favoriteCollectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.favoriteCollectionViewCell.rawValue )
        collectionView.backgroundColor = .white
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 600
        layout.itemSize = CGSize(width: view.layer.frame.width, height: view.layer.frame.width / 2)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        getImageData()
    }
    
    private func getImageData(){
        do {
            let favorite = try WeatherPhotoPersistenceHelper.manager.getPhotos()
            self.favoriteCollectionView.reloadData()
        }catch{
            print(error)
        }
    }
    
}

extension FavoriteViewController: UICollectionViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension FavoriteViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.favoriteCell.rawValue, for: indexPath) as? FavoriteCollectionViewCell else {return UICollectionViewCell()}
        
        let info = favoriteImage[indexPath.item]
        ImageHelper.shared.getImage(urlStr: info.imageURL) { (result) in
            switch result{
            case .failure(_):
                let alert = UIAlertController(title: "Sorry", message: "We Seem to be having problem loading your image. Please reload and try again", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                
            case .success(let image):
                DispatchQueue.main.async {
                    cell.favoriteImageView.image = image
                }
            }
        }
        
        return cell
    }
    
    
}
