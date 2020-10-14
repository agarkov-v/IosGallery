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
    
}

protocol LoginPresenterProtocol {
    
}

class LoginPresenter {
    
    private weak var view: LoginView!
    private let router: LoginRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: LoginView,
         _ router: LoginRouter) {
        self.view = view
        self.router = router
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
}
