//
//  GalleryPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift
import RxNetworkApiClient

protocol GalleryView: BaseView {
    
}

protocol GalleryPresenterProtocol {
    
}

class GalleryPresenter {
    
    private weak var view: GalleryView!
    private let router: GalleryRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: GalleryView,
         _ router: GalleryRouter) {
        self.view = view
        self.router = router
    }
}

extension GalleryPresenter: GalleryPresenterProtocol {
    
}
