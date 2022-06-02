//
//  Prefs.swift
//  weather-prodia
//
//  Created by Krisna on 29/05/22.
//

import Foundation
import UIKit

struct Prefs {
    
    static let user : String = "user"
    
    static func saveUser(user: String) {
        UserDefaults.standard.set(user, forKey: "user")
    }
    
    static func getUser() -> String {
        if let user = UserDefaults.standard.value(forKey: "user") as? String {
            return user
        }
        return ""
    }
    
    static func removeSession() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
}
