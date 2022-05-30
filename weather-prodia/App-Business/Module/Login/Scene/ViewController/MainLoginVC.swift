//
//  MainLoginVC.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import UIKit

class MainLoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblUstInput: UILabelBarlowRegular!
    @IBOutlet weak var tfUsrInput: UITextField!
    @IBOutlet weak var lblPinInput: UILabel!
    @IBOutlet weak var tfPinInput: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    struct VCProperty {
        static let storyboard = "Login"
        static let identifier = "MainLoginVCIdentifier"
        static let cornerRadius = 15.0
        static let stringEmpty : String = ""
        static let stringUserValid = "Username / Email"
        static let stringPinValid = "Password / Pin"
        static let stringUserNotValid = "Username / Email tidak terdaftar"
        static let stringPinNotValid = "Password / Pin tidak cocok"
    }
    
    var router : LoginRouter?
    var vm = MainLoginVM()
    var flagRouterHome : Int = 0
    
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
        self.tfUsrInput.delegate = self
        self.tfPinInput.delegate = self
        self.vm.setupUserData()
    }
    
    func setupRouter(){
        self.router = LoginRouter(viewController: self)
    }
    
    func setupAction(){
        self.btnLogin.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
    }
    
    func setupView(){
        
        self.lblUstInput.text = VCProperty.stringUserValid
        self.lblPinInput.text = VCProperty.stringPinValid
        
        self.tfUsrInput.addTarget(self, action: #selector(textFieldDidChangeUser(textField:)), for: .editingChanged)
        self.tfPinInput.addTarget(self, action: #selector(textFieldDidChangePin(textField:)), for: .editingChanged)
        
    }
    
    @objc func btnClick(button: UIButton) {
        if flagRouterHome == 0 {
            self.vm.validateDataLogin(dataUser: tfUsrInput.text ?? "", dataPin: tfPinInput.text ?? "")
            flagRouterHome = 1
        }
    }
    
    @objc func textFieldDidChangeUser(textField: UITextField) {
        self.lblUstInput.textColor = BaseColor.gray
        self.lblUstInput.text = VCProperty.stringUserValid
        

    }
    
    @objc func textFieldDidChangePin(textField: UITextField) {
        self.lblPinInput.textColor = BaseColor.gray
        self.lblPinInput.text = VCProperty.stringPinValid
    }
    
    func textField(_ textfield: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textfield == tfPinInput {
            let maxLength = 6
            let currentString: NSString = (textfield.text ?? "") as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else {
            let maxLength = 40
            let currentString: NSString = (textfield.text ?? "") as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    }
}

extension MainLoginVC : MainLoginVMProtocol {
    func didSuccesGetDataLoginRCF(rep: LoginDataRCF) {
        DispatchQueue.main.async {
            
        }
    }
    
    func didErrGetDataLoginRCF() {
        DispatchQueue.main.async {
            
        }
    }
    
    func didSuccessValidateLogin() {
        DispatchQueue.main.async {
            self.router?.navigateToHome()
        }
    }
    
    func didErrEmailValidateLogin() {
        DispatchQueue.main.async {
            self.lblUstInput.textColor = .red
            self.lblUstInput.text = VCProperty.stringUserNotValid
        }
    }
    
    func didErrPinValidateLogin() {
        DispatchQueue.main.async {
            self.lblPinInput.textColor = .red
            self.lblPinInput.text = VCProperty.stringPinNotValid
        }
    }
}
