//
//  FavoriteVC.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
        private enum Identifier:String{
        case favoriteCell
    }
    
    var favoriteImage = [FavoritePhotosModel](){
        didSet{
            myTableView.reloadData()
        }
    }
    
    lazy var myTableView: UITableView = {
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

      let myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight ))
        myTableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: Identifier.favoriteCell.rawValue)
        myTableView.dataSource = self
        myTableView.delegate = self
        return myTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImageData()
         self.view.addSubview(myTableView)
    }
    
    private func getImageData(){
        do {
            favoriteImage = try WeatherPhotoPersistenceHelper.manager.getPhotos()
            print(favoriteImage)
        }catch{
            print(error)
        }
    }
    
   private func actionSheet(tag: Int) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { (delete) in
            //write code to delete a cell
            let deleteItem = self.favoriteImage[tag]
            self.favoriteImage.remove(at: tag)
            
            do {
                try WeatherPhotoPersistenceHelper.manager.deleteFavorite(withMessage: deleteItem.imageData)
            } catch {
                print(error)
            }
        })
        actionSheet.addAction(delete)
    present(actionSheet, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionSheet(tag: indexPath.row)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.favoriteCell.rawValue) as? FavoriteTableViewCell  else {return UITableViewCell()}
       
        let info = favoriteImage[indexPath.item]
         cell.favoriteImageView.image = UIImage(data: info.imageData )
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
        
    }

}
