//
//  UpdateUserEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxNetworkApiClient

struct UpdateUserEntity: JsonBodyConvertible {
    
    let id: Int
    let email: String
    let username: String
    let birthday: String
}
