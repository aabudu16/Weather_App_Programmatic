//
//  FavoriteCollectionViewCell.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/13/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    let favoriteImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setupView(){
        self.contentView.addSubview(favoriteImageView)
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([favoriteImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
                                     favoriteImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
                                     favoriteImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
                                     favoriteImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 5)])
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
