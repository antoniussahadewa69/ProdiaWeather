//
//  Service-Enum.swift
//  weather-prodia
//
//  Created by Krisna on 30/05/22.
//

import Foundation

enum ResultStatusResp<Value> {
    case success(Value)
    case failure(String)
    case serverBussy
}
