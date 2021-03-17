//
//  RegistrationUseCase.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.03.2021.
//

import RxSwift

protocol RegistrationUseCase {

//    @discardableResult
    func registerUser(email: String, phone: String, fullName: String, userName: String, birthday: String, password: String) -> Completable
}

class RegistrationUseCaseImp: RegistrationUseCase {

    private let registrationGateway: RegistrationGateway

    init(registrationGateway: RegistrationGateway) {
        self.registrationGateway = registrationGateway
    }

//    @discardableResult
    func registerUser(email: String, phone: String, fullName: String, userName: String, birthday: String, password: String) -> Completable {
        let registrationData = RegistrationEntity(email: email, phone: phone, fullName: fullName, password: password, username: userName, birthday: birthday)
        return registrationGateway.registerUser(registrationData: registrationData).flatMapCompletable { registerData -> Completable in
            return Completable.empty()
        }
    }
}
