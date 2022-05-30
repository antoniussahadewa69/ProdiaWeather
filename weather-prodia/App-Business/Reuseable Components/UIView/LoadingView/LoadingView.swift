//
//  LoadingView.swift
//  weather-prodia
//
//  Created by Krisna on 29/05/22.
//

import Foundation
import UIKit

@IBDesignable
class LoadingView: UIView {
    
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    static let nibName = "LoadingView"
    static let identifier = "LoadingViewIdentifier"
    
    func setupView() {
        self.lottieAnimationView.setupAnimation(animation: .loadingState, animationSpeed: 1)
        self.lottieAnimationView.roundCorners(value: 15)
        self.roundCorners(value: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(nibName: LoadingView.nibName)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup(nibName: LoadingView.nibName)
    }

    override func awakeFromNib() {
        xibSetup(nibName: LoadingView.nibName)
    }
}
