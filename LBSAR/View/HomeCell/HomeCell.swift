//
//  HomeCell.swift
//  LBSARApp
//
//  Created by Sahi Joshi on 11/23/19.
//  Copyright © 2019 Sahi Joshi. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    var homeItem: HomeItem? {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        if let aHomeItem = homeItem {
            lblTitle.text = aHomeItem.itemTitle
            imgIcon.image = UIImage (named: aHomeItem.key)
        }
    }
}
