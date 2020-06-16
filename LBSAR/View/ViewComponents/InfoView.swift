//
//  InfoView.swift
//  LBSARApp
//
//  Created by Sahi Joshi on 11/24/19.
//  Copyright © 2019 Sahi Joshi. All rights reserved.
//

import UIKit

class InfoView: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblOpen: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadView() -> InfoView{
        let customInfoWindow = Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)?[0] as! InfoView
        customInfoWindow.layer.backgroundColor = UIColor(red: 62/255, green: 92/255, blue: 111/255, alpha: 0.9).cgColor
        customInfoWindow.layer.cornerRadius = 4
        customInfoWindow.imagePlace.layer.cornerRadius = 4
        return customInfoWindow
    }
    
}
