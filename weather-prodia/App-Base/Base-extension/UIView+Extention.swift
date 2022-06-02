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
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          layer.mask = mask
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
        UIApplication.shared.keyWindow?.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

extension UIView {
    
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
