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
        static let windSpeed : Double = 0.0
    }
    
    let service = HomeService()
    var delegate : MainHomeVMProtocol?
    
    var dataLat : Double = VMProperty.lat
    var dataLong : Double = VMProperty.long
    var dataTimezone : String = VMProperty.timezone
    var dataPressure : Int = VMProperty.pressure
    var dataHumidity : Int = VMProperty.humidity
    var dataWindSpeed : Double = VMProperty.windSpeed
    
    var menuHomeSetup : [HomeMenuCVCellPayload] = []
}

extension MainHomeVM {
    
    func setDataCVCell(data: DataWeatherResp) -> [HomeMenuCVCellPayload] {
        var menuHomeData : [HomeMenuCVCellPayload] = []
        
        for index in 0..<6 {
            var iswindSpeed : Bool = false
            var ishumidity : Bool = false
            var ispressure : Bool = false
            var istimezone : Bool = false
            var islong : Bool = false
            var islat : Bool = false
            if index == 0 {
                iswindSpeed = true
            }
            if index == 1 {
                ishumidity = true
            }
            if index == 2 {
                ispressure = true
            }
            if index == 3 {
                istimezone = true
            }
            if index == 4 {
                islong = true
            }
            if index == 5 {
                islat = true
            }
            let data : HomeMenuCVCellPayload = HomeMenuCVCellPayload(
                isWindSpeed: iswindSpeed,
                isHumidity: ishumidity,
                isPressure: ispressure,
                isTimezone: istimezone,
                isLong: islong,
                isLat: islat,
                dataLat: data.lat ?? 0.0,
                dataLong: data.lon ?? 0.0,
                dataTimezone: data.timezone ?? "",
                dataPressure: data.current?.pressure ?? 0,
                dataHumidity: data.current?.humidity ?? 0,
                dataWindSpeed: data.current?.wind_speed ?? 0.0)
            menuHomeData.append(data)
        }
        if menuHomeData.count == 6 {
            self.delegate?.didSuccesHomeGetData(rep: data)
        }
        return menuHomeData
        
        
    }
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
                self.menuHomeSetup = self.setDataCVCell(data:resp)
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
