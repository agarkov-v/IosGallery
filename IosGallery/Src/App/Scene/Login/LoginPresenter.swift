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
    func showErrorView(_ error: SignInError)
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
            .subscribe(onCompleted: {
                //OpenVC
                print("Open VC")
            }, onError: { [weak self] (error) in
                guard let self = self else { return }
                let message = error.localizedDescription
                print("signIn error: \(message), || \(error)")
//                if let authError = error as? AppError {
//                    message = authError.localizedDescription
//                }
                self.view.showErrorView(.notMatch)
                
            })
    }
}
