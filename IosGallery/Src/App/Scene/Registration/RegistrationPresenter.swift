//
//  RegistrationPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import Foundation
import RxSwift

protocol RegistrationView: BaseView {

}

protocol RegistrationPresenter {
    func closeScreen()
    func onSignUp(email: String, phone: String, fullName: String, userName: String, birthday: String, password: String)
}

class RegistrationPresenterImp: RegistrationPresenter {
    private weak var view: RegistrationView?
    private let router: RegistrationRouter
    private let registrationUseCase: RegistrationUseCase
    private var disposeBag = DisposeBag()
    
    init(_ view: RegistrationView,
         _ router: RegistrationRouter,
         _ registrationUseCase: RegistrationUseCase) {
        self.view = view
        self.router = router
        self.registrationUseCase = registrationUseCase
    }

    func closeScreen() {
        router.closeModal()
    }

    func onSignUp(email: String, phone: String, fullName: String, userName: String, birthday: String, password: String) {
        registrationUseCase.registerUser(email: email, phone: phone, fullName: fullName, userName: userName, birthday: birthday, password: password)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: { [weak self] in
                self?.view?.showActivityIndicator()
            },
            onDispose: { [weak self] in
                self?.view?.hideActivityIndicator()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.view?.showDialog(message: "You have successfully sign up".localization(), action: { [weak self] _ in
                    self?.router.closeModal()
                })
            },
            onError: { [weak self] error in
                self?.view?.showErrorDialog(message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
}
