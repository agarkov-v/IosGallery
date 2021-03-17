//
//  RegistrationEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.03.2021.
//

import RxNetworkApiClient

struct RegistrationEntity: JsonBodyConvertible {

    let email: String
    let phone: String
    let fullName: String
    let password: String
    let username: String
    let birthday: String
    let roles = [""]
}
