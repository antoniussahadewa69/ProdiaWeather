//
//  MainHomeVM.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation

protocol MainHomeVMProtocol : class {
    func didSuccesHomeGetData(rep:DataWeatherResp)
    func didErrHomeGetData()
}

class MainHomeVM {
    
    struct VMProperty {
        static let lat : Double = 0.0
        static let long : Double = 0.0
        static let timezone : String = ""
        static let pressure : Int = 0
        static let humidity : Int = 0
        static let windSpeed : Int = 0
    }
    
    let service = HomeService()
    var delegate : MainHomeVMProtocol?
    
    var dataLat : Double = VMProperty.lat
    var dataLong : Double = VMProperty.long
    var dataTimezone : String = VMProperty.timezone
    var dataPressure : Int = VMProperty.pressure
    var dataHumidity : Int = VMProperty.humidity
    var dataWindSpeed : Int = VMProperty.windSpeed
}

extension MainHomeVM {
    func getDataWeather(){
        service.getDataWeather(completion: {
            res in
            switch res {
            case .serverBussy:
                self.delegate?.didErrHomeGetData()
                break
            case .failure:
                self.delegate?.didErrHomeGetData()
                break
            case .success(let resp):
                self.delegate?.didSuccesHomeGetData(rep: resp)
                self.dataLat = resp.lat ?? VMProperty.lat
                self.dataLong = resp.lon ?? VMProperty.long
                self.dataTimezone = resp.timezone ?? VMProperty.timezone
                self.dataPressure = resp.current?.pressure ?? VMProperty.pressure
                self.dataHumidity = resp.current?.humidity ?? VMProperty.humidity
                self.dataWindSpeed = resp.current?.wind_speed ?? VMProperty.windSpeed
                break
            }
       })
    }
}
