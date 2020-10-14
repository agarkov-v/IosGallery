//
//  ImportPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol ImportView: BaseView {
    
}

protocol ImportPresenterProtocol {
    
}

class ImportPresenter {
    
    private weak var view: ImportView!
    private let router: ImportRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: ImportView,
         _ router: ImportRouter) {
        self.view = view
        self.router = router
    }
}

extension ImportPresenter: ImportPresenterProtocol {
    
}

