//
//  MarkerCustomInfo.swift
//  LBSARApp
//
//  Created by Sahi Joshi on 11/24/19.
//  Copyright © 2019 Sahi Joshi. All rights reserved.
//

import UIKit
import Cosmos
import CoreLocation

protocol MarkerCustomInfoDelegate {
    func didTouchMap()
}

class MarkerCustomInfo: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblClose: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!

    var delegate: MarkerCustomInfoDelegate?

    @IBAction func pressDirection(_ sender: UIButton) {
        if let aDelegate = delegate {
            aDelegate.didTouchMap()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadView() -> MarkerCustomInfo{
        let customInfoWindow = Bundle.main.loadNibNamed("MarkerCustomInfo", owner: self, options: nil)?[0] as! MarkerCustomInfo
        customInfoWindow.layer.backgroundColor = UIColor(red: 62/255, green: 92/255, blue: 111/255, alpha: 0.9).cgColor
        customInfoWindow.layer.cornerRadius = 4
        customInfoWindow.imagePlace.layer.cornerRadius = 4
        customInfoWindow.ratingView.settings.fillMode = .precise

        return customInfoWindow
    }
}
