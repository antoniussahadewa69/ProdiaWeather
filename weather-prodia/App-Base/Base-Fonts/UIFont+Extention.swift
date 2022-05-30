//
//  UIFont+Extention.swift
//  weather-prodia
//
//  Created by Krisna on 27/05/22.
//

import Foundation
import UIKit

extension UIFont {
    
    enum FontLibrary: String {
        
        case barlowBlack = "Barlow-Black"
        case barlowBold = "Barlow-Bold"
        case barlowExtraBold = "Barlow-ExtraBold"
        case barlowExtraLight = "Barlow-ExtraLight"
        case barlowLight = "Barlow-Light"
        case barlowMedium = "Barlow-Medium"
        case barlowRegular = "Barlow-Regular"
        case barlowSemiBold = "Barlow-SemiBold"
        case barlowThin = "Barlow-Thin"
        
        static func defaultStyle() -> FontLibrary {
            return .barlowRegular
        }
    }
    
    static func font(size: CGFloat, fontType: FontLibrary = FontLibrary.defaultStyle()) -> UIFont {
        return UIFont(name: fontType.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
