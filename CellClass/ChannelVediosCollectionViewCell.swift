//
//  ChannelVediosCollectionViewCell.swift
//  KidzYoutubeApp
//
//  Created by ZeeshanFayyaz on 13/07/2018.
//  Copyright © 2018 ZeeshanFayyaz. All rights reserved.
//

import UIKit

class ChannelVediosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var CellViewShadow: UIView!
    @IBOutlet weak var cellFavouriteImage: UIImageView!
    
    var fav = false
}
