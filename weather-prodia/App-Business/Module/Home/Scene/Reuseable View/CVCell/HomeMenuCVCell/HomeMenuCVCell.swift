//
//  HomeMenuCVCell.swift
//  weather-prodia
//
//  Created by Krisna on 02/06/22.
//

import UIKit

struct HomeMenuCVCellPayload {
    var isWindSpeed : Bool = true
    var isHumidity : Bool = true
    var isPressure : Bool = true
    var isTimezone : Bool = true
    var isLong : Bool = true
    var isLat : Bool = true
    
    var dataLat : Double = 0.0
    var dataLong : Double = 0.0
    var dataTimezone : String = ""
    var dataPressure : Int = 0
    var dataHumidity : Int = 0
    var dataWindSpeed : Double = 0.0
}

class HomeMenuCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var viewHomeMenuCVCell: UIView!
    @IBOutlet weak var lblTitleHomeMenu: UILabelBarlowSemiBold!
    @IBOutlet weak var lblDescHomeMenu: UILabelBarlowRegular!
    
    struct CVProperty{
        static let identifier : String = "HomeMenuCVCellIdentifier"
        static let nibName = "HomeMenuCVCell"
        static let titleLat : String = "Latitude"
        static let titleLong : String = "longitude"
        static let titleTimezone : String = "Timezone"
        static let titlePressure : String = "Pressure"
        static let titleHumidity : String = "Humidity"
        static let titleWindSpeed : String = "Wind Speed"
        
    }
    
    static let identifier = CVProperty.identifier
    static let nibName = CVProperty.nibName
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(payload: HomeMenuCVCellPayload) {
        self.viewHomeMenuCVCell.roundCorners(value: 10)
        self.viewHomeMenuCVCell.layer.borderWidth = 1
        self.viewHomeMenuCVCell.layer.borderColor = BaseColor.gray.cgColor
        
        if payload.isLat {
            lblTitleHomeMenu.text = CVProperty.titleLat
            lblDescHomeMenu.text = "\(payload.dataLat)"
        } else if payload.isLong {
            lblTitleHomeMenu.text = CVProperty.titleLong
            lblDescHomeMenu.text = "\(payload.dataLong)"
        } else if payload.isTimezone {
            lblTitleHomeMenu.text = CVProperty.titleTimezone
            lblDescHomeMenu.text = "\(payload.dataTimezone)"
        } else if payload.isHumidity {
            lblTitleHomeMenu.text = CVProperty.titleHumidity
            lblDescHomeMenu.text = "\(payload.dataHumidity)"
        } else if payload.isPressure {
            lblTitleHomeMenu.text = CVProperty.titlePressure
            lblDescHomeMenu.text = "\(payload.dataPressure)"
        } else if payload.isWindSpeed {
            lblTitleHomeMenu.text = CVProperty.titleWindSpeed
            lblDescHomeMenu.text = "\(payload.dataWindSpeed)"
        }
    }

}
