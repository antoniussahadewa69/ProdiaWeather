//
//  MainWeatherVM.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation

protocol MainWeatherVMProtocol : class {
    func didSuccesWeatherGetData(rep:LoginDataRCF)
    func didErrWeatherGetData()
}

class MainWeatherVM {
    
    struct VMProperty {
        
    }
    
    let service = WeatherService()
    var delegate : MainWeatherVMProtocol?
    
    
    func setupUserData(){
        
    }
}

extension MainWeatherVM {
    
}
