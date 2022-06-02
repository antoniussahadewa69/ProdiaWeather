//
//  MainInfoVC.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import UIKit

class MainInfoVC: UIViewController {
    
    struct VCProperty {
        
    }
    
    var router : InfoRouter?
    var vm = MainWeatherVM()
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVM()
        self.setupRouter()
        self.setupView()
        self.setupAction()
    }
    
    func setupVM(){
        self.vm.setupUserData()
    }
    
    func setupRouter(){
        self.router = InfoRouter(viewController: self)
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

extension MainInfoVC {
    
}
