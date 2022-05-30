//
//  HomeResp.swift
//  weather-prodia
//
//  Created by Krisna on 30/05/22.
//

import Foundation

struct DataWeatherResp: Decodable {
    var lat: Double?
    var lon: Double?
    var timezone: String?
    var current: CurrentWeather?
}
    
struct CurrentWeather: Decodable {
    var pressure: Int?
    var humidity: Int?
    var wind_speed: Int?
}

struct ApiErrorDto : Decodable {
    var status: Int?
    var message: String?
}
        
