//
//  ChangePasswordEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxNetworkApiClient

struct ChangePasswordEntity: JsonBodyConvertible {
    
    let id: Int
    let oldPassword: String
    let newPassword: String
}
