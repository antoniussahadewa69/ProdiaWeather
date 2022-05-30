//
//  MainLoginVM.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation

protocol MainLoginVMProtocol : class {
    func didSuccesGetDataLoginRCF(rep:LoginDataRCF)
    func didErrGetDataLoginRCF()
    
    func didSuccessValidateLogin()
    func didErrEmailValidateLogin()
    func didErrPinValidateLogin()
}

class MainLoginVM {
    
    struct VMProperty {
        static let userNameDummy : String = "antonius.sahadewa@gmail.com"
        static let pinDummy : String = "123456"
    }
    
    let service = LoginService()
    var delegate : MainLoginVMProtocol?
    var user: String = VMProperty.userNameDummy
    var pin: String = VMProperty.pinDummy
    
    func setupUserData(){
        getRemoteConfig()
    }
    
    func getRemoteConfig(){
        RemoteConfigFirebase.delegate = self
        RemoteConfigFirebase.fetchFirebaseRemoteConfigData(control: .login_data)
    }
    
    func validateDataLogin(dataUser:String,dataPin:String){
        if user != dataUser {
            self.delegate?.didErrEmailValidateLogin()
        } else if pin != dataPin {
            self.delegate?.didErrPinValidateLogin()
        } else {
            self.delegate?.didSuccessValidateLogin()
            Prefs.saveUser(user: dataUser)
        }
    }
}

extension MainLoginVM : RemoteConfigFirebaseProtocol {
    func didSuccessLoginDataRCF(resp: LoginDataRCF) {
    }
    
    func didFailureLoginDataRCF() {
    }
    
    func didErrorLoginDataRCF() {
    }
    
    
}
