//
//  FavoriteTableViewCell.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(favoriteImageView)
        setupView()
    }

    
    let favoriteImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
   
  private func setupView(){
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            favoriteImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            favoriteImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            favoriteImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
