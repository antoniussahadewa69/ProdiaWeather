//
//  LoginRouter.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import UIKit

class LoginRouter {
    
    var vc : UIViewController? = nil
    
    init(viewController : UIViewController) {
        self.vc = viewController
    }
    
    func navigateToHome(){
        guard let vc = UIStoryboard(name:MainHomeVC.VCProperty.storyboard, bundle:nil).instantiateViewController(withIdentifier: MainHomeVC.VCProperty.identifier) as? MainHomeVC else {
            return
        }
        self.vc?.navigationController?.pushViewController(vc, animated:true)
    }
}
