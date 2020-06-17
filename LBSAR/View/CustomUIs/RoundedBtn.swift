//
//  RoundedBtn.swift
//  LBSAR
//
//  Created by skj on 10.3.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import UIKit

class RoundedBtn: UIButton {
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.layer.cornerRadius = 5
            self.backgroundColor = UIColor(red: 57, green: 88, blue: 108)
        }
}
