//
//  SJProgressView.swift
//  SJProgressHUD
//
//  Created by Sahi Joshi on 9/06/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit


public enum MaskType {
    case none
    case clear
    case dark
}

public class SKJProgressHUD: UIView {
    
    internal var centerView: UIView?
    internal var lblStatus:StatusLabel?
    internal var lblTitle: TitleLabel?
    internal var lblMessage: MessageLabel?
    internal var lblAlertMessage: AlertMessageLabel?
    internal var btnOk: AlertOptionsButton?
    internal var btnCancel: AlertOptionsButton?
    internal var actionClosure: ((Bool) -> Void)?
    internal var dismissActionClosure: ((Bool) -> Void)?
    internal var maskType: MaskType = .none
    internal var cornerRadius:CGFloat = 5
    internal var style:UIActivityIndicatorViewStyle?
    internal var activityBackgroundColor:UIColor?
    internal var activityIndicator: UIActivityIndicatorView?
    internal var lblProgressPercentage: UILabel?
    internal var progressBar: UIProgressView?
    internal var totalCount: Int = 0
    
    var centerViewWidth = 300
    var centerViewHeight = 100
    var tempCenterViewWidth = 0

    internal var dismissHudOnBackgroundTap = false {
        didSet {
            if dismissHudOnBackgroundTap {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
                addGestureRecognizer(tapGesture)
            }
        }
    }
    
    internal var progressValue:Int = 0 {
        didSet {
            var fractionProgress:Float = 0
            if progressValue != 0, progressBar != nil, lblProgressPercentage != nil {
                fractionProgress = Float(progressValue) / Float(totalCount)
                lblProgressPercentage?.text = "\(Int(fractionProgress * 100)) %"
                progressBar?.setProgress(fractionProgress, animated: true)
            }
            
            if progressValue == totalCount {
                let dispatchTime = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                    SKJProgressHUD.dismiss()
                }
            }
        }
    }
    
    
    class var sharedInstance: SKJProgressHUD {
        struct Singleton {
            static let instance:SKJProgressHUD = SKJProgressHUD()
        }
        return Singleton.instance
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        switch maskType {
        case .clear:
            frame = (UIApplication.shared.delegate?.window?!.bounds)!
            backgroundColor = UIColor.darkGray.withAlphaComponent(0)
            center = (UIApplication.shared.delegate?.window??.center)!
            activityIndicator?.center = center
            centerView?.center = center
            
        case .dark:
            frame = (UIApplication.shared.delegate?.window?!.bounds)!
            backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
            center = (UIApplication.shared.delegate?.window??.center)!
            activityIndicator?.center = center
            centerView?.center = center
            
        case .none:
            frame = CGRect(x: 0, y: 0, width: tempCenterViewWidth, height: centerViewHeight)
            backgroundColor = UIColor.white.withAlphaComponent(1)
            center = (UIApplication.shared.delegate?.window??.center)!
            layer.cornerRadius = 5
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override public func willRemoveSubview(_ subview: UIView) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Rearrange views when orientation is changed.
    
    @objc func reArranageViews(){
        self.setNeedsLayout()
    }
    
    private func addOrientationChangeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reArranageViews), name: .UIApplicationWillChangeStatusBarFrame, object: UIApplication.shared)
    }
    
    // dismiss hud when tap on background
    
    @objc private func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        var dismissHud = false
        
        if let aCenterView = centerView {
            if !aCenterView.bounds.contains(gestureRecognizer.location(in: aCenterView)) {
                dismissHud = true
            }
        }
        
        if let aActivityIndicator = activityIndicator {
            if !aActivityIndicator.bounds.contains(gestureRecognizer.location(in: aActivityIndicator)) {
                dismissHud = true
            }
        }
        
        if dismissHud {
            SKJProgressHUD.dismiss()
        }
    }
    
    private func setActivityIndicatorProperties() {
        activityIndicator?.backgroundColor = self.activityBackgroundColor
        activityIndicator?.layer.cornerRadius = self.cornerRadius
        activityIndicator?.layer.shadowColor = UIColor.darkGray.cgColor
        activityIndicator?.layer.shadowOpacity = 0.6
        activityIndicator?.layer.shadowRadius = 4
        activityIndicator?.layer.shadowOffset = CGSize(width: 2, height: 2)
        activityIndicator?.activityIndicatorViewStyle = self.style!
    }
    
    private func setCenterViewProperties() {
        centerView?.layer.cornerRadius = self.cornerRadius
        centerView?.layer.shadowColor = UIColor.darkGray.cgColor
        centerView?.layer.shadowOpacity = 0.6
        centerView?.layer.shadowRadius = 4
        centerView?.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    public static func show(withStatus status: String = "", style: UIActivityIndicatorViewStyle = .gray, backgroundColor: UIColor = .white, mask: MaskType = .none) {
        sharedInstance.show(withStatus: status, style: style, backgroundColor: backgroundColor, mask: mask)
    }
    
    
    public static func showAlertMessage(withTitle title: String = "", message: String = "", delay: Int = 0, backgoundColor: UIColor = .white, mask: MaskType = .none) {
        sharedInstance.showAlertMessage(withTitle: title, message: message, delay: delay, backgoundColor: backgoundColor, mask: mask)
    }
    
    public static func showProgressBar(_ title: String, totalCount:Int = 0, backgoundColor: UIColor = .white, mask: MaskType = .none) {
        sharedInstance.showProgressBar(title, totalCount: totalCount, backgoundColor: backgoundColor, mask: mask)
    }
    
    public static func showAlertMessageWithOptions(_
        btnOkTitle: String = "Ok", btnCancelTitle: String = "Cancel", message:String = "", maskType: MaskType = .none, backgoundColor: UIColor = .white, okAction: @escaping(Bool) -> Void = { _ in }, cancelAction: @escaping(Bool) -> Void = { _ in }) {
        sharedInstance.showAlertMessageWithOptions(btnOkTitle, btnCancelTitle: btnCancelTitle, message: message, maskType: maskType, backgoundColor: backgoundColor, okAction: okAction, cancelAction: cancelAction)
    }
    
    // show progress hud
    
    private func show(withStatus status: String, style: UIActivityIndicatorViewStyle, backgroundColor: UIColor, mask: MaskType) {
        addOrientationChangeNotification()
        layer.cornerRadius = cornerRadius
        self.tempCenterViewWidth = centerViewWidth - 100
        self.maskType = mask
        self.style = style
        self.activityBackgroundColor = backgroundColor

        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: tempCenterViewWidth, height: centerViewHeight))
        }
        setActivityIndicatorProperties()
        
        if !status.isEmpty {
            lblStatus = StatusLabel(withRespectTo: activityIndicator!)
            activityIndicator?.addSubview(lblStatus!)
        }
        lblStatus?.text = status
        
        if let window = UIApplication.shared.keyWindow {
            addSubview(activityIndicator!)
            window.addSubview(self)
        }
        
        activityIndicator?.startAnimating()
        setNeedsLayout()
    }
    
    // show alert message with certain delay on time
    
    private func showAlertMessage(withTitle title: String, message: String, delay: Int, backgoundColor: UIColor, mask: MaskType) {
        if centerView == nil, let window = UIApplication.shared.keyWindow, lblTitle == nil, lblMessage == nil {
            self.tempCenterViewWidth = centerViewWidth
            self.maskType = mask

            centerView = UIView(frame: CGRect(x: 0, y: 0, width: tempCenterViewWidth, height: centerViewHeight))
            centerView?.backgroundColor = backgoundColor
            setCenterViewProperties()
            
            if !title.isEmpty {
                lblTitle = TitleLabel(withRespectTo: centerView!)
                centerView?.addSubview(lblTitle!)
            }
            lblTitle?.text = title
            
            if !message.isEmpty {
                lblMessage = MessageLabel(withRespectTo: centerView!, andTitleLabel: lblTitle!)
                centerView?.addSubview(lblMessage!)
            }
            lblMessage?.text = message

            addSubview(centerView!)
            window.addSubview(self)
            
            let dispatchTime = DispatchTime.now() + .seconds(delay)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                SKJProgressHUD.dismiss()
            }
        }
    }
    
    // show alert message with options to confirm or cancel
    
    private func showAlertMessageWithOptions(_ btnOkTitle: String, btnCancelTitle: String, message:String, maskType: MaskType, backgoundColor: UIColor, okAction: @escaping(Bool) -> Void, cancelAction: @escaping(Bool) -> Void) {
        if centerView == nil, let window = UIApplication.shared.keyWindow, lblAlertMessage == nil, btnOk == nil, btnCancel == nil {
            self.actionClosure = okAction
            self.dismissActionClosure = cancelAction
            self.tempCenterViewWidth = centerViewWidth
            self.maskType = maskType

            centerView = UIView(frame: CGRect(x: 0, y: 0, width: tempCenterViewWidth, height: centerViewHeight))
            centerView?.backgroundColor = backgoundColor
            setCenterViewProperties()
            
            lblAlertMessage = AlertMessageLabel(withRespectTo: centerView!)
            lblAlertMessage?.text = message
            
            btnOk = AlertOptionsButton(frame: CGRect(x: 0, y: (lblAlertMessage?.frame.height)!, width: ((centerView?.frame.width)! / 2 - 1), height: ((centerView?.frame.size.height)! / 2) - 10))
            btnOk?.roundCorners([.bottomLeft], radius: 5)
            btnOk?.setTitle(btnOkTitle, for: .normal)
            btnOk?.addTarget(self, action: #selector(okAction(sender:)), for: .touchUpInside)
            
            btnCancel = AlertOptionsButton(frame: CGRect(x: (btnOk?.frame.size.width)! + 1, y: (btnOk?.frame.origin.y)!, width: (btnOk?.frame.size.width)! + 1, height:  (btnOk?.frame.size.height)!))
            btnCancel?.roundCorners([.bottomRight], radius: 5)
            btnCancel?.setTitle(btnCancelTitle, for: .normal)
            btnCancel?.addTarget(self, action: #selector(dismissAction(sender:)), for: .touchUpInside)
            
            centerView?.addSubview(lblAlertMessage!)
            centerView?.addSubview(btnOk!)
            centerView?.addSubview(btnCancel!)
            
            addSubview(centerView!)
            window.addSubview(self)
        }
    }
    
    // show data progress
    
    private func showProgressBar(_ title: String, totalCount:Int, backgoundColor: UIColor, mask: MaskType) {
        if centerView == nil, let window = UIApplication.shared.keyWindow, lblTitle == nil, lblProgressPercentage == nil,  progressBar == nil {
            self.tempCenterViewWidth = centerViewWidth
            self.maskType = mask
            self.totalCount = totalCount

            centerView = UIView(frame: CGRect(x: 0, y: 0, width: tempCenterViewWidth, height: centerViewHeight))
            centerView?.backgroundColor = backgoundColor
            setCenterViewProperties()
            
            let xOffsetLblTitle = CGFloat(10)
            
            if !title.isEmpty {
                lblTitle = TitleLabel(withRespectTo: centerView!)
                centerView?.addSubview(lblTitle!)
            }
            lblTitle?.text = title
            
            progressBar = UIProgressView(progressViewStyle: .default)
            progressBar?.frame = CGRect(x: xOffsetLblTitle, y: (centerView?.frame.height)! / 2 + 5, width: (centerView?.frame.width)! - xOffsetLblTitle * 2, height: 5)
            
            lblProgressPercentage = UILabel(frame: CGRect(x: (centerView?.frame.size.width)!/2 - 25, y: (progressBar?.frame.origin.y)! - 22, width: 50, height: 21))
            lblProgressPercentage?.textAlignment = .center
            lblProgressPercentage?.font = UIFont.systemFont(ofSize: 12)
            lblProgressPercentage?.textColor = UIColor(red: 80, green: 80, blue: 80)
            
            centerView?.addSubview(lblProgressPercentage!)
            centerView?.addSubview(progressBar!)
            
            addSubview(centerView!)
            window.addSubview(self)
        }

    }
    
    @objc private func okAction(sender: Any) {
        if let actionClosure = actionClosure {
            actionClosure(true)
        }
    }
    
    @objc private func dismissAction(sender: Any) {
        if let dismissClosure = dismissActionClosure {
            dismissClosure(true)
        }
    }

    // dismiss hud
    
    public static func dismiss() {
        // Dismiss status
        if let activityIndicator = self.sharedInstance.activityIndicator {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            sharedInstance.removeFromSuperview()
            sharedInstance.activityIndicator = nil
        }
        
        // Dismiss progressbar
        if let progressView = sharedInstance.progressBar {
            progressView.removeFromSuperview()
            sharedInstance.lblProgressPercentage?.removeFromSuperview()
            sharedInstance.progressBar = nil
            sharedInstance.lblProgressPercentage = nil
        }
        
        // Dismiss alert message with delay
        if let centerView = sharedInstance.centerView {
            UIView.animate(withDuration: 0.2, animations: {
                centerView.alpha = 0
            }, completion: { (success) in
                
                sharedInstance.lblTitle?.removeFromSuperview()
                sharedInstance.lblMessage?.removeFromSuperview()
                sharedInstance.lblAlertMessage?.removeFromSuperview()
                sharedInstance.btnOk?.removeFromSuperview()
                sharedInstance.btnCancel?.removeFromSuperview()
                sharedInstance.centerView?.removeFromSuperview()
                sharedInstance.removeFromSuperview()
                sharedInstance.lblTitle = nil
                sharedInstance.lblMessage = nil
                sharedInstance.lblAlertMessage = nil
                sharedInstance.btnOk = nil
                sharedInstance.btnCancel = nil
                sharedInstance.centerView = nil
                sharedInstance.dismissActionClosure = nil
                sharedInstance.actionClosure = nil
            })
        }
    }

}

