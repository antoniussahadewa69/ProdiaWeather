//
//  ViewController.swift
//  weather-prodia
//
//  Created by Krisna on 27/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!

    var timer = Timer()
    var poseDuration = 20
    var currentPoseIndex = 0
    var router : BaseRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // initialise the display
        setupRouter()
        setupView()
    }
    
    func setupRouter(){
        self.router = BaseRouter(viewController: self)
    }
    
    func setupView(){
        progressBar.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        if progressBar.progress < 1.0 {
            progressBar.progress += 0.1
        } else {
            self.timer.invalidate()
            if Prefs.getUser() == "" {
                self.router?.navigateToLogin()
            } else {
                self.router?.navigateToHome()
            }
        }
    }
}
