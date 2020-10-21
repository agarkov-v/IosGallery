//
//  AccountPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol AccountView: BaseView {
    
}

protocol AccountPresenterProtocol {
    func openAccountSettings()
}

class AccountPresenter: AccountPresenterProtocol {
    
    private weak var view: AccountView!
    private let router: AccountRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: AccountView,
         _ router: AccountRouter) {
        self.view = view
        self.router = router
    }
    
    func openAccountSettings() {
        router.openAccountSettings()
    }
}

