//
//  WeatherCollectionViewCell.swift
//  Weather_App_Programmatic
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var highLabel: UILabel!
    @IBOutlet var lowLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }

}
