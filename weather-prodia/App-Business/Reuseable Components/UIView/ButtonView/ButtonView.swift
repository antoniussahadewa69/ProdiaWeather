//
//  ButtonView.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import UIKit


@IBDesignable
class ButtonView: UIView {
    
    @IBOutlet weak var coreButton: UIButton!
    
    @IBInspectable var nibName:String? = "ButtonView"
    
    var contentView:UIView?
    
    enum Style {
        case filled
        case nude
        case nudeWhite
        case nudeNoBorder
        case disabled
        case clear
        case hightlight
        case filledYellow
        case hightlightRed
        case hightlightBlue
        case nudeOrange
        case filledGreen
        case filledBlue
        case filledOrange
        case greyNude
        
        var backgroundColor: UIColor? {
            switch self {
            case .filled:
                return BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .nude:
                return UIColor.clear
            case .nudeWhite:
                return UIColor(named: "#ffffff")
            case .nudeNoBorder :
                return UIColor(named: "#ffffff")
            case .disabled:
                return BaseColor.Properties.baseDisabledColor//UIColor(string: "#e5e5e5")
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor.clear
            case .filledYellow:
                return BaseColor.Properties.dandelion
            case .nudeOrange:
                return UIColor.clear
            case .filledGreen:
                return BaseColor.borderGreenBtn
            case .filledBlue:
                return UIColor.clear
            case .filledOrange:
                return BaseColor.borderOrangeBtn
            case .hightlightRed:
                return UIColor.clear
            case .hightlightBlue:
                return UIColor.clear
            case .greyNude:
                return BaseColor.Properties.baseDisabledColor
            }
        }
        
        var titleColor: UIColor? {
            switch self {
            case .filled:
                return UIColor(named: "#ffffff")
            case .nude:
                return  BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .nudeWhite:
                return  BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .nudeNoBorder:
                return  BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .disabled:
                return BaseColor.disabledTitleColor//UIColor(string: "#ffffff")
            case .clear:
                return BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .hightlight:
                return UIColor(named: "#ffffff")
            case .filledYellow:
                return BaseColor.black
            case .nudeOrange:
                return BaseColor.borderOrangeBtn
            case .filledGreen:
                return UIColor.white
            case .filledBlue:
                return BaseColor.borderBlueBtn
            case .filledOrange:
                return UIColor.white
            case .hightlightRed:
                return BaseColor.baseRedColor
            case .hightlightBlue:
                return BaseColor.Properties.baseColor
            case .greyNude:
                return BaseColor.Properties.baseColor
            }
        }
        
        var borderColor: UIColor? {
            switch self {
            case .filled:
                return  BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .nude:
                return  BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .nudeWhite:
                return  BaseColor.Properties.baseColor//UIColor(string: "#0376bf")
            case .nudeNoBorder:
                return UIColor.clear
            case .disabled:
                return  BaseColor.Properties.baseDisabledColor//UIColor(string: "#e5e5e5")
            case .clear:
                return UIColor.clear
            case .hightlight:
                return UIColor(named: "#ffffff")
            case .filledYellow:
                return BaseColor.Properties.dandelion
            case .nudeOrange:
                return BaseColor.borderOrangeBtn
            case .filledGreen:
                return BaseColor.borderGreenBtn
            case .filledBlue:
                return BaseColor.borderBlueBtn
            case .filledOrange:
                return BaseColor.borderOrangeBtn
            case .hightlightRed:
                return BaseColor.baseRedColor
            case .hightlightBlue:
                return BaseColor.Properties.baseColor
            case .greyNude:
                return UIColor.clear
            }
        }
        
        var isEnable: Bool {
            switch self {
            case .disabled:
                return false
            default:
                return true
            }
        }
        
    }
    
    override func layoutSubviews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupInit()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    private func setupInit() {
        self.coreButton.layer.cornerRadius = 8
    }
    
    func setAtomic(type: Style = .filled, title: String = "", messageError: String = "") {
        self.coreButton.setTitle(title, for: .normal)
        self.coreButton.setTitleColor(type.titleColor, for: .normal)
        self.coreButton.backgroundColor = type.backgroundColor
        self.coreButton.layer.borderColor = type.borderColor?.cgColor
        self.coreButton.isEnabled = type.isEnable
        self.coreButton.layer.borderWidth = 1.0
        
    }
    
    func setCornerRadius(cornerRadius: CGFloat) {
        self.coreButton.layer.cornerRadius = cornerRadius
    }
    
}
