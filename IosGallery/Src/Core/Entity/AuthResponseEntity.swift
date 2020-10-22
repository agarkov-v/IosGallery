//
//  AuthResponseEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

struct AuthResponseEntity: Codable{
    
    let error: String
    let errorDescription: String
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
    }
}
