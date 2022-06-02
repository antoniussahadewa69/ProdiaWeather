//
//  Base-Router.swift
//  weather-prodia
//
//  Created by Krisna on 29/05/22.
//

import Foundation
import UIKit

struct AppRouter {
    
    static func switchToLoginPin(animated: Bool = true, completion: (() -> Void)?) {
        guard let vc = UIStoryboard(name:MainLoginVC.VCProperty.storyboard, bundle:nil).instantiateViewController(withIdentifier: MainLoginVC.VCProperty.identifier) as? MainLoginVC else {
            return
        }
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = vc
    }
    
    
}

class BaseRouter {
    
    var vc : UIViewController? = nil
    
    
    
    init(viewController : UIViewController) {
        self.vc = viewController
    }
    
    func navigateToLogin(){
        guard let vc = UIStoryboard(name:MainLoginVC.VCProperty.storyboard, bundle:nil).instantiateViewController(withIdentifier: MainLoginVC.VCProperty.identifier) as? MainLoginVC else {
            return
        }
        self.vc?.navigationController?.pushViewController(vc, animated:true)
    }
    
    func navigateToHome(){
        guard let vc = UIStoryboard(name:MainHomeVC.VCProperty.storyboard, bundle:nil).instantiateViewController(withIdentifier: MainHomeVC.VCProperty.identifier) as? MainHomeVC else {
            return
        }
        self.vc?.navigationController?.pushViewController(vc, animated:true)
    }

}
