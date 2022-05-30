//
//  BaseColor.swift
//  weather-prodia
//
//  Created by Krisna on 27/05/22.
//

import UIKit

class BaseColor: UIColor {
    
    //MARK: BASE THEME
    struct Properties {
        static let baseColor : UIColor? = UIColor(named: "#0045e5")
        static let blackColor = UIColor.black
        static let dandelion : UIColor? = UIColor(named: "#eee809")
        
        static let baseEnabledTitleColor : UIColor? = UIColor(named: "#333333")
        static let baseEnabledYellowColor : UIColor? = UIColor(named: "#eee809")
        
        static let baseDisabledColor : UIColor? = UIColor(named: "#e7eaf3")
        static let baseDisabledTitleColor : UIColor? = UIColor(named: "#949494")
        
        static let baseWhiteColor : UIColor? = UIColor(named: "#ffffff")
        
        static let colorOrangeVerifyEmail : UIColor? = UIColor(named: "#ff8402")
        static let colorGreenVerifyEmail : UIColor? = UIColor(named: "#47dba5")
        static let colorBlueVerifyEmail : UIColor? = UIColor(named: "#0045e5")
        static let baseRedColor: UIColor? = UIColor(named: "#fc030f")
        static let separatorView: UIColor? = UIColor(named: "#E5E5E5")
    }
    
    
    //MARK: BASE BUTTON
    static let disabledColor : UIColor? = Properties.baseDisabledColor
    static let disabledTitleColor = Properties.baseDisabledTitleColor
    
    static let enabledTitleColor = Properties.blackColor
    static let enabledColor : UIColor? = Properties.baseColor
    static let enabledDandelion : UIColor? = Properties.dandelion
    
    static let borderOrangeBtn : UIColor? = Properties.colorOrangeVerifyEmail
    static let borderGreenBtn : UIColor? = Properties.colorGreenVerifyEmail
    static let borderBlueBtn : UIColor? = Properties.colorBlueVerifyEmail
    
    static let alertWrongColor: UIColor? = UIColor(named: "#ff7575")
    
    //MARK: LOGIN
    static let loginBtnEnabled = Properties.dandelion
    static let loginBtnDisabled = Properties.baseDisabledColor
    
    //MARK: PIN
    static let pinPlaceholderColor : UIColor? = Properties.baseWhiteColor
    
    static let baseRedColor: UIColor? =  Properties.baseRedColor
    
    static let baseColor: UIColor? =  Properties.baseColor
    
    static let separatorView: UIColor? =  Properties.separatorView
}
