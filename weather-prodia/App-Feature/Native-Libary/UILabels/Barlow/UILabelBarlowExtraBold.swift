//
//  UILabelBarlowExtraBold.swift
//  weather-prodia
//
//  Created by Krisna on 27/05/22.
//

import Foundation
import UIKit

@IBDesignable
class UILabelBarlowExtraBold: UILabel {
    
    override func prepareForInterfaceBuilder() {
        setUILabel()
    }
    
    override func awakeFromNib() {
        setUILabel()
    }
    
    private func setUILabel() {
        font = UIFont.font(size: font.pointSize, fontType: .barlowExtraBold)
    }

}
