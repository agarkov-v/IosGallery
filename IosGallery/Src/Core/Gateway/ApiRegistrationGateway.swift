//
//  ApiRegistrationGateway.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.03.2021.
//

import RxSwift

protocol RegistrationGateway {

    func registerUser(registrationData: RegistrationEntity) -> Single<RegistrationEntity>
}

class ApiRegistrationGateway: ApiBaseGateway, RegistrationGateway {

    func registerUser(registrationData: RegistrationEntity) -> Single<RegistrationEntity> {
        return apiClient.execute(request: .registerUser(registrationData: registrationData))
    }
}
