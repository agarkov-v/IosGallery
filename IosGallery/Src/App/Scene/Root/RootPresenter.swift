//
//  RootPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol RootView: BaseView {
    
}

protocol RootPresenterProtocol {
    
}

class RootPresenter {
    
    private weak var view: RootView!
    private let router: RootRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: RootView,
         _ router: RootRouter) {
        self.view = view
        self.router = router
    }
}

extension RootPresenter: RootPresenterProtocol {
    
}
