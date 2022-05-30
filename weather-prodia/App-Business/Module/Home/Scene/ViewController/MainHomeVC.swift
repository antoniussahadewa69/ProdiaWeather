//
//  MainHomeVC.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import UIKit

class MainHomeVC: UIViewController {
    
    @IBOutlet weak var lblValueLat: UILabelBarlowRegular!
    @IBOutlet weak var lblValueLong: UILabelBarlowRegular!
    @IBOutlet weak var lblValueTimezone: UILabelBarlowRegular!
    @IBOutlet weak var lblValuePressure: UILabelBarlowRegular!
    @IBOutlet weak var lblValueHumidity: UILabelBarlowRegular!
    @IBOutlet weak var lblValueWindSpeed: UILabelBarlowRegular!
    
    
    struct VCProperty {
        static let storyboard : String = "Home"
        static let identifier : String = "mainHomeVCIdentifier"
    }
    
    var router : HomeRouter?
    var vm = MainHomeVM()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVM()
        self.setupRouter()
        self.setupView()
        self.setupAction()
    }
    
    func setupVM(){
        self.vm.delegate = self
        self.vm.getDataWeather()
    }
    
    func setupRouter(){
        self.router = HomeRouter(viewController: self)
    }
    
    func setupAction(){
        
    }
    
    func setupView(){
        
    }
}

extension MainHomeVC : MainHomeVMProtocol {
    
    func didSuccesHomeGetData(rep: DataWeatherResp) {
        DispatchQueue.main.async {
            self.lblValueLat.text = "\(self.vm.dataLat)"
            self.lblValueLong.text = "\(self.vm.dataLong)"
            self.lblValuePressure.text = "\(self.vm.dataPressure)"
            self.lblValueTimezone.text = "\(self.vm.dataTimezone)"
            self.lblValueHumidity.text = "\(self.vm.dataHumidity)"
            self.lblValueWindSpeed.text = "\(self.vm.dataWindSpeed)"
        }
    }
    
    func didErrHomeGetData() {
        DispatchQueue.main.async {
            self.showToast(message: "Internal Server Err")
        }
    }
}
