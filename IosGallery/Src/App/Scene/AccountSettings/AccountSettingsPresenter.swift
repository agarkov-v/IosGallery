//
//  AccountSettingsPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol AccountSettingsView: BaseView {
    
}

protocol AccountSettingsPresenterProtocol {
    
}

class AccountSettingsPresenter {
    
    private weak var view: AccountSettingsView!
    private let router: AccountSettingsRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: AccountSettingsView,
         _ router: AccountSettingsRouter) {
        self.view = view
        self.router = router
    }
}

extension AccountSettingsPresenter: AccountSettingsPresenterProtocol {
    
}

