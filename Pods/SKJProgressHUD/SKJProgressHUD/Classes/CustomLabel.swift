//
//  CustomLabel.swift
//  SJProgressHUD
//
//  Created by Sahi Joshi on 9/06/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit



class BaseCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        numberOfLines = 0
    }
    
    override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }
        
        let attributedText = NSAttributedString(string: labelText, attributes: [NSFontAttributeName: font])
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
        
        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }
        
        super.drawText(in: newRect)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TitleLabel: BaseCustomLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withRespectTo centerView: UIView) {
        let xOffsetLblTitle = CGFloat(10)
        let yOffsetLblTitle = CGFloat(15)

        let aFrame = CGRect(x: xOffsetLblTitle, y: yOffsetLblTitle, width: (centerView.frame.width) - xOffsetLblTitle * 2, height: 21)
        self.init(frame: aFrame)
        
        font = UIFont.systemFont(ofSize: 16)
        textColor = UIColor(red: 50, green: 50, blue: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StatusLabel: BaseCustomLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withRespectTo activityIndicator: UIActivityIndicatorView) {
        let xOffsetLblStatus = CGFloat(10)
        let yOffsetLblStatus = CGFloat(12)

        let aFrame = CGRect(x: xOffsetLblStatus, y: (activityIndicator.frame.size.height)/2 + yOffsetLblStatus, width: (activityIndicator.frame.width) - xOffsetLblStatus * 2, height: ((activityIndicator.frame.height) / 2) - yOffsetLblStatus - 5)
        self.init(frame: aFrame)
        
        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor(red: 50, green: 50, blue: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MessageLabel: BaseCustomLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withRespectTo centerView: UIView, andTitleLabel lblTitle: TitleLabel) {
        let xOffsetLblTitle = CGFloat(10)
        let yOffsetLblTitle = CGFloat(15)

        let aFrame = CGRect(x: xOffsetLblTitle, y: (lblTitle.frame.origin.y) + (lblTitle.frame.size.height) + 2, width: (centerView.frame.width) - xOffsetLblTitle * 2, height: (centerView.frame.size.height) - (lblTitle.frame.size.height) - yOffsetLblTitle - 10)
        self.init(frame: aFrame)

        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor(red: 80, green: 80, blue: 80)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AlertMessageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 3
        textAlignment = .center
    }
    
    convenience init(withRespectTo centerView: UIView) {
        let xOffsetLblTitle = CGFloat(0)
        let yOffsetLblTitle = CGFloat(0)

        let aFrame = CGRect(x: xOffsetLblTitle, y: yOffsetLblTitle, width: (centerView.frame.width) - xOffsetLblTitle * 2, height: ((centerView.frame.size.height) / 2) + 10)
        self.init(frame: aFrame)
        
        font = UIFont.systemFont(ofSize: 16)
        textColor = UIColor(red: 80, green: 80, blue: 80)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

