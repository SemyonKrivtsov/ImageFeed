//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Семён Кривцов on 09.06.2024.
//

import Foundation

final class OAuth2TokenStorage {
    
    private let userDefaults = UserDefaults.standard
    private let authTokenKey = "authTokenKey"
    
    var authToken: String? {
        get {
            return userDefaults.string(forKey: authTokenKey)
        }
        set {
            guard let newValue else { return }
            userDefaults.set(newValue, forKey: authTokenKey)
        }
    }
}
