//
//  LoginPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol LoginView: BaseView {
    func showErrorView(message: String)
    func hideErrorView()
}

protocol LoginPresenter {
    func signIn(_ username: String, _ password: String)
}

class LoginPresenterImp: LoginPresenter {
    
    private weak var view: LoginView!
    private let router: LoginRouter
    private let authUseCase: AuthUseCase
    private var disposeBag = DisposeBag()
    
    init(_ view: LoginView,
         _ router: LoginRouter,
         _ authUseCase: AuthUseCase) {
        self.view = view
        self.router = router
        self.authUseCase = authUseCase
    }
    
    func signIn(_ username: String, _ password: String) {
        authUseCase.login(username: username, password: password)
            .observeOn(MainScheduler.instance)
            .do(onSubscribed: { [weak self] in
                self?.view.showActivityIndicator()
            }, onDispose: { [weak self] in
                self?.view.hideActivityIndicator()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.router.openRootScreen()
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                var message = error.localizedDescription
                if message == "The operation couldn’t be completed. (IosGallery.AppError error 0.)" {
                    message = "Invalid username or password".localization()
                }
                self.view.showErrorView(message: message)
            })
            .disposed(by: disposeBag)
    }
}
