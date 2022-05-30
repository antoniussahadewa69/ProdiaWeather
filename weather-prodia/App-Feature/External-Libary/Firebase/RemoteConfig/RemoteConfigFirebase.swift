//
//  RemoteConfigFirebase.swift
//  weather-prodia
//
//  Created by Krisna on 28/05/22.
//

import Foundation
import FirebaseRemoteConfig

enum RemoteConfigTypeControl : String {
    case login_data = "login_data"
}

var timeIntervalFetchRemoteFirebase : Int = 1

protocol RemoteConfigFirebaseProtocol : class {
    func didSuccessLoginDataRCF(resp: LoginDataRCF)
    func didFailureLoginDataRCF()
    func didErrorLoginDataRCF()
}

class RemoteConfigFirebase {
    
    static let defaultErrorFirebase = "FIR Remote Config Error"
    static var remoteConfig = RemoteConfig.remoteConfig()
    static var delegate : RemoteConfigFirebaseProtocol?
    
    
    static func setupRemoteConfig() -> RemoteConfigSettings{
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = TimeInterval(timeIntervalFetchRemoteFirebase)
        return settings
    }
    
    static func fetchFirebaseRemoteConfigData(control : RemoteConfigTypeControl) {
        switch control {
        case .login_data :
            remoteConfig.configSettings = setupRemoteConfig()
            remoteConfig.fetch() { (status, error) -> Void in
              if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate() { (changed, error) in
                    guard error == nil else {
                        print("error fetch firebase")
                        self.delegate?.didFailureLoginDataRCF()
                        return
                    }
                    let stringJsonMock = "{\"user\":\"test\",\"password\":\"475869\"}"
                    let stringJson = self.remoteConfig.configValue(forKey: control.rawValue).stringValue ?? stringJsonMock
                    do {
                        let resp = try JSONDecoder().decode(LoginDataRCF.self, from: (stringJson.data(using: .utf8)!))
                        self.delegate?.didSuccessLoginDataRCF(resp: resp)
                    } catch {
                        self.delegate?.didErrorLoginDataRCF()
                    }
                }
              } else {
                print("Error: \(error?.localizedDescription ?? "No error available.")")
                self.delegate?.didFailureLoginDataRCF()
                return
              }
            }
            break
        }
    }
}

