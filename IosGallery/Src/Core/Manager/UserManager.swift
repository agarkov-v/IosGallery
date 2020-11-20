//
//  UserManager.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

class UserManager {
    
    private let userDefaultsManager: UserDefaultsManager

    var token: TokenEntity? {
        get {
            userDefaultsManager.getData(.token)
        }
        set {
            userDefaultsManager.saveData(.token, object: newValue)
        }
    }

    var user: UserEntity? {
        get {
            userDefaultsManager.getData(.user)
        }
        set {
            userDefaultsManager.saveData(.user, object: newValue)
        }
    }
    
    init(userDefaultsManager: UserDefaultsManagerImp) {
        self.userDefaultsManager = userDefaultsManager
    }
}
