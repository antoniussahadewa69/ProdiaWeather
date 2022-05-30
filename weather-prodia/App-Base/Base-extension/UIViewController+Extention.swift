//
//  UIViewController+Extention.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import SVProgressHUD

enum StateLoad {
    case show
    case dismiss
}

extension UIViewController {
    
    static var isPresentLoading: Bool = false
    static let tagContainerLoading = 100000
    static let tagSubViewLoading = 100001
    
    enum AMNavigationTheme {
        case normal
        case Transparent
        case BlueBase
        
        func primaryColor(on vc: UIViewController) -> UIColor {
            switch self {
            case .normal:
                return UIColor.yellow
            case .Transparent:
                return UIColor.clear
            case .BlueBase:
                return UIColor.blue
            }
        }
        
        var secondaryColor: UIColor {
            switch self {
            case .normal:
                return UIColor.black
            case .Transparent:
                return UIColor.white
            case .BlueBase:
                return UIColor.white
            }
        }
    }
    
    enum AMViewNavigatorType {
        case none
        case back
        case close
        case home
        
        var icon: UIImage {
            switch self {
            case .none:
                return UIImage()
            case .back:
                return UIImage(named: "ic_arrow_back")!
            case .home:
                return UIImage(named: "ic_arrow_back")!
            case .close:
                return UIImage(named: "ic_close")!
            }
        }
        
        var callback: Selector {
            switch self {
            case .none:
                return #selector(onBlankTapped)
            case .back:
                return #selector(onBackTapped)
            case .close:
                return #selector(onCloseTapped)
            case .home:
                return #selector(onBackHome)
            }
            
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
     }
     
     @objc private func onBlankTapped() { }
     
     @objc private func onBackTapped() {
         self.navigationController?.popViewController(animated: true)
     }
     
     @objc private func onBackHome() {
         //BaseRouter.navigateToHome(viewController: self)
     }
     
     @objc private func onCloseTapped() {
         self.dismiss(animated: true, completion: nil)
     }
     
     func removeBorderNavigation(){
         //border in navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
     }
     
     func setTextNavigation(theme: AMNavigationTheme = .normal, title: String, navigator: AMViewNavigatorType = .none, navigatorCallback: Selector? = nil) {
         self.setupTitleForNavigation(theme: theme, title: title)
         self.setupNavigatorForNavigation(theme: theme, type: navigator, navigatorCallback: navigatorCallback)
         self.setupBackgroundForNavigation(theme: theme)
     }
    
    private func setupTitleForNavigation(theme: AMNavigationTheme, title: String) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = true
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.font(size: 18, fontType: .barlowBold), NSAttributedString.Key.foregroundColor: theme.secondaryColor]
    }
    
    private func setupNavigatorForNavigation(theme: AMNavigationTheme, type: AMViewNavigatorType, navigatorCallback: Selector? = nil) {
        if let callback = navigatorCallback {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: type.icon, style: .plain, target: self, action: callback)
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: type.icon, style: .plain, target: self, action: type.callback)
        }
        self.navigationItem.leftBarButtonItem?.tintColor = theme.secondaryColor
        self.navigationItem.rightBarButtonItem?.tintColor = theme.secondaryColor
    }
    
    private func setupBackgroundForNavigation(theme: AMNavigationTheme) {
        self.navigationController?.navigationBar.barTintColor = theme.primaryColor(on: self)
        
        switch theme {
        case .normal, .BlueBase:
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.view.backgroundColor = .white
            self.navigationController?.navigationBar.barTintColor = .white
        case .Transparent:
            self.navigationController?.navigationBar.setBackgroundImage (UIImage(), for: .default) //UIImage.init(named: "transparent.png")
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = .clear
            self.navigationController?.navigationBar.barTintColor = .none
            self.navigationController?.navigationBar.barStyle = .default
            self.navigationController?.navigationBar.backgroundColor = .clear
        }
    }
    
    func stateLoading(state: StateLoad) {
        switch state {
        case .show:
            let loadingView = LoadingView()
            loadingView.setupView()
            loadingView.roundCorners(value: 15)
            popUpStateLoading(withView: loadingView)
        
        case .dismiss:
            dismissPopupStateLoading()
        }
    }
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/4, y: self.view.frame.size.height/2, width: (self.view.frame.size.width/4)*2 , height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 12)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
    }
    
    func popUpStateLoading(withView: UIView) {
        if !UIViewController.isPresentLoading {
            UIViewController.isPresentLoading = true
            
            let tagPlaceholder = UIViewController.tagContainerLoading
            let tagSubView = UIViewController.tagSubViewLoading
            
            let widthView: CGFloat = 80
            let heightView: CGFloat = 80
            
            let viewContainer = UIView()
            viewContainer.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            viewContainer.tag = tagPlaceholder
            viewContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            
            let subView = withView
            subView.frame = CGRect(x: (self.view.frame.width / 2) - (widthView / 2),
                                   y: (self.view.frame.height / 2) - (heightView / 2),
                                   width: widthView, height: heightView)
            subView.isUserInteractionEnabled = true
            subView.layer.zPosition = 2
            subView.tag = tagSubView
            
            subView.alpha = 1
            viewContainer.alpha = 1
            
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(viewContainer)
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(subView)
            
        } else {}
        
    }
    
    func dismissPopupStateLoading() {
        if let viewWithTag = UIApplication.shared.windows.first?.viewWithTag(UIViewController.tagContainerLoading) {
            viewWithTag.removeFromSuperview()
        }

        if let subViewWithTag = UIApplication.shared.windows.first?.viewWithTag(UIViewController.tagSubViewLoading) {
            subViewWithTag.removeFromSuperview()
        }
        UIViewController.isPresentLoading = false
    }
}
