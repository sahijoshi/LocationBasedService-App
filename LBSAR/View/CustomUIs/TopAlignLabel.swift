//
//  TopAlignLabel.swift
//  LBSAR
//
//  Created by skj on 10.3.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import UIKit

class TopAlignLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    class TopAlignLabel: UILabel {
        
        override func drawText(in rect:CGRect) {
            guard let labelText = text else {  return super.drawText(in: rect) }
            
            let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: font])
            var newRect = rect
            newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
            
            if numberOfLines != 0 {
                newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
            }
            
            super.drawText(in: newRect)
        }
    }

}
