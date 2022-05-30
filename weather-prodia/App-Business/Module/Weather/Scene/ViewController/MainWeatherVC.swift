//
//  MainWeatherVC.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import UIKit

class MainWeatherVC: UIViewController {
    
    struct VCProperty {
        
    }
    
    var router : WeatherRouter?
    var vm = MainWeatherVM()
    
    override func viewWillAppear(_ animated: Bool) {
        //.setTextNavigation(theme: .normal, title: VCProperty.navigationTitle, navigator: .back, navigatorCallback: nil)
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
        self.vm.setupUserData()
    }
    
    func setupRouter(){
        self.router = WeatherRouter(viewController: self)
    }
    
    func setupAction(){
//        self.btnPLMCRegisterVC.coreButton.addTapGestureRecognizer{
//            self.stateLoading(state: .show)
//            self.vm.getStatusOnPLMC()
//        }
    }
    
    func setupView(){
//        self.lblDescPLMCRegisterVC.font = UIFont.font(size: VCProperty.fontSize16, fontType: .interRegular)
//        self.lblNoHpPLMCRegisterVC.font = UIFont.font(size: VCProperty.fontSize24, fontType: .interRegular)
//        self.lblNoHpPLMCRegisterVC.text = self.getExtensionPhone(phone: vm.phoneNumber)
//        self.btnPLMCRegisterVC.layer.cornerRadius = VCProperty.cornerRadius
//        self.btnPLMCRegisterVC.setAtomic(type: .filled, title: VCProperty.titleButton, messageError: VCProperty.stringEmpty)
    }
}

extension MainWeatherVC : MainWeatherVMProtocol {
    func didSuccesWeatherGetData(rep: LoginDataRCF) {
        DispatchQueue.main.async {
            
        }
    }
    
    func didErrWeatherGetData() {
        DispatchQueue.main.async {
            
        }
    }
}
