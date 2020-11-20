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

protocol AccountSettingsPresenter {
    func onBackBarButtonItem()
}

class AccountSettingsPresenterImp: AccountSettingsPresenter {
    
    private weak var view: AccountSettingsView!
    private let router: AccountSettingsRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: AccountSettingsView,
         _ router: AccountSettingsRouter) {
        self.view = view
        self.router = router
    }
    
    func onBackBarButtonItem() {
        router.pop()
    }
}

