//
//  DetailPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol DetailView: BaseView {
    
}

protocol DetailPresenterProtocol {
    
}

class DetailPresenter {
    
    private weak var view: DetailView!
    private let router: DetailRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: DetailView,
         _ router: DetailRouter) {
        self.view = view
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
}
