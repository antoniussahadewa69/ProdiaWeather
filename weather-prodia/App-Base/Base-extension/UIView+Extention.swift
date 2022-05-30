//
//  UIView+Extention.swift
//  weather-prodia
//
//  Created by Krisna on 29/05/22.
//

import Foundation
import UIKit

enum ShadowPosition {
    case Top
    case Bottom
}

extension UIView {
    
    fileprivate typealias Action = (() -> Void)?
    
// src : https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    func setRadiusWithShadow(cornerRadius: CGFloat = 4.0) {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath.cgPath
    }
    
    func setRadiusWithOutShadow(cornerRadius: CGFloat = 4.0) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
    
//    salah
    func createDottedLine(color: CGColor = UIColor(named: "#979797")!.cgColor, position : CGRect = CGRect(x: 0, y: 0, width: 0, height: 0), radius : CGFloat = 0) {
        let yourViewBorder = CAShapeLayer()
        var shape = CGRect()
        if (position.width == 0 && position.height == 0){
            shape = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        } else {
            shape = position
        }
        yourViewBorder.strokeColor = color
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = shape
        yourViewBorder.fillColor = nil
        yourViewBorder.lineJoin = CAShapeLayerLineJoin.round
        yourViewBorder.path = UIBezierPath(roundedRect: shape,cornerRadius: radius).cgPath
        layer.addSublayer(yourViewBorder)
    }
    
    func addShadow(cornerRadius: CGFloat = 8.0, position: ShadowPosition = .Bottom) {
        
        layer.shadowOffset = CGSize(width:0, height:0)
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 0.25).cgColor
        layer.borderWidth = 0.2
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        switch position {
        case .Top:
            layer.shadowOffset = CGSize(width: 0, height: -4)
        case .Bottom:
            layer.shadowOffset = CGSize(width: 0, height: 4)
        }
        layer.masksToBounds = false
    }
    
    func addAnotherDefaultShadow(cornerRadius: CGFloat = 4.0) {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          layer.mask = mask
      }
    
    public func addCellVoucherShadow(cornerRadius: CGFloat = 8.0) {
        layer.shadowOffset = CGSize(width:0, height:0)
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 0.25).cgColor
        layer.borderWidth = 0.2
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
    }
    
    public func addBottomViewShadow(cornerRadius: CGFloat = 8.0) {
        layer.shadowOffset = CGSize(width:0, height:1100)
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 0.25).cgColor
        layer.borderWidth = 0.2
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -6)
        layer.masksToBounds = false
    }
    
    public func addSettingTableViewShadow(cornerRadius: CGFloat = 8.0) {
           layer.shadowOffset = CGSize(width:2, height:2)
           layer.cornerRadius = cornerRadius
           layer.borderColor = UIColor(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 0.25).cgColor
           layer.borderWidth = 0.2
           layer.shadowRadius = 4
           layer.shadowOpacity = 0.25
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOffset = CGSize(width: 0, height: 4)
           layer.masksToBounds = false
    }
    
    
}

//IBDesignableSetup
extension UIView{
    
    func xibSetup(nibName : String) {
        var containerView = UIView()
        containerView = loadViewFromNib(nibName: nibName)
        containerView.frame = bounds
        containerView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        addSubview(containerView)
    }

    func loadViewFromNib(nibName : String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func roundedTop(){
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.topLeft,.topRight],
                                cornerRadii: CGSize(width: 10, height:  10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func roundedBottom(){
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.bottomLeft,.bottomRight],
                                cornerRadii: CGSize(width: 10, height:  10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func roundedTopBottomLeft(){
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 5, height:  5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func roundedTopLeft(){
        let path = UIBezierPath(roundedRect: self.bounds,
                                 byRoundingCorners: [.topLeft],
                                 cornerRadii: CGSize(width: self.frame.height/2, height:  self.frame.height/2))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func roundedBottomLeft(){
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.bottomLeft],
                                cornerRadii: CGSize(width: self.frame.height/2, height:  self.frame.height/2))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

        func setBorder() {
            self.layer.cornerRadius = 15
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
    
        func setRounded() {
            self.layer.cornerRadius = 10
        }
    
        func setRoundedTwo() {
            self.layer.cornerRadius = 10
            self.layer.borderWidth = 1
            self.layer.borderColor = BaseColor.separatorView?.cgColor
        }
    
    func setRoundedSemi(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    

        func roundedTopMessage(isFullScreen : Bool = false){
            DispatchQueue.main.async {
                var bound = CGRect()
                if isFullScreen{
                    bound = UIScreen.main.bounds
                }else {
                    bound = self.bounds
                }
                let path = UIBezierPath(roundedRect:  bound,
                                    byRoundingCorners: [.topRight,.topLeft,.topRight],
                                    cornerRadii: CGSize(width: 20, height:  20))
                let maskLayer = CAShapeLayer()
                maskLayer.path = path.cgPath
                self.layer.mask = maskLayer
            }
        }
    
    //MARK: Debt Rounded Cell
    func notRoundedTopMessage() {
        DispatchQueue.main.async {
            var bound = CGRect()
            bound = self.bounds
            let path = UIBezierPath(roundedRect:  bound,
                                byRoundingCorners: [.topRight,.topLeft,.topRight],
                                cornerRadii: CGSize(width: 0, height:  0))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-150, width: 200, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
//    self.view.addSubview(toastLabel)
    UIApplication.shared.keyWindow?.addSubview(toastLabel)
    UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

extension UIView {
    func makeClearHole(rect: CGRect, cornerRadius: CGFloat = 0) {
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillColor = BaseColor.Properties.baseColor?.cgColor
        
        let pathToOverlay = UIBezierPath(rect: self.bounds)
        pathToOverlay.append(UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius))
        pathToOverlay.usesEvenOddFillRule = true
        maskLayer.path = pathToOverlay.cgPath
        
        layer.mask = maskLayer
    }
    
    public func roundCorners(_ corners: UIRectCorner = .allCorners, value: CGFloat) {
        guard corners != .allCorners else {
            layer.cornerRadius = value
            return
        }

        guard #available(iOS 11.0, *) else {
            let path = UIBezierPath(roundedRect: bounds,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: value, height: value))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = path.cgPath
            layer.mask = maskLayer

            return
        }

        layer.cornerRadius = value
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
