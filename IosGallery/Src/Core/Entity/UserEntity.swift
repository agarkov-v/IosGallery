//
//  UserEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

struct UserEntity: Codable {
    
    let id: Int
    let email: String
    let enabled: Bool
    let phone: String
    let fullName: String
    let username: String
    let birthday: String
    let roles: [String]
}
