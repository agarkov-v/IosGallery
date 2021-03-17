//
//  UserDefaultsManager.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

enum UserDefaultsKeyType: String {
    case token
    case user
}

protocol UserDefaultsManager {
    
    func saveData<T: Codable>(_ key: UserDefaultsKeyType, object: T)
    func getData<T: Codable>(_ key: UserDefaultsKeyType) -> T?
}

class UserDefaultsManagerImp: UserDefaultsManager {
    
    private let userDefaults = UserDefaults.standard
    
    func saveData<T: Codable>(_ key: UserDefaultsKeyType, object: T) {
        if let data = try? JSONEncoder().encode(object) {
            userDefaults.set(data, forKey: key.rawValue)
        }
    }
    
    func getData<T: Codable>(_ key: UserDefaultsKeyType) -> T? {
        if let data = userDefaults.data(forKey: key.rawValue),
            let object = try? JSONDecoder().decode(T.self, from: data) {
            return object
        }
        return nil
    }
}
