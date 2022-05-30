//
//  HomeService.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation

class HomeService {
    
    let stringLat = "?lat="
    let stringLong = "&lon="
    let stringExclude = "&exclude="
    let stringAppId = "&appid="
    
    var latitude : Double = 33.44
    var longitude : Double = -94.04
    var exclude : String = "hourly,daily"
    var apppid : String = "a81e5d9547ee6514f72477b7f1f8c93c"
    
    let client = RestHelper()
    
    func createUrlWeather()-> String {
        let baseUrl : String = "https://api.openweathermap.org/data/2.5/onecall"
        var url : String = baseUrl + stringLat + "\(latitude)" + stringLong + "\(longitude)" + stringExclude + exclude + stringAppId + apppid
        return url
    }
    
    func getDataWeather(completion:@escaping(ResultStatusResp<DataWeatherResp>)->()){
        let _ = client.get(url: createUrlWeather(), responseType: DataWeatherResp.self, complete: {data in
            completion(.success(data))
        }, errors: { error in
            completion(.failure(error.message ?? ""))
        })
    }
}
