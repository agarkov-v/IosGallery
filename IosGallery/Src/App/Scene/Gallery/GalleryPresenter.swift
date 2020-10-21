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
    func openTestDetail(image: UIImage, label: String, user: String, date: String, descr: String)
}

class GalleryPresenter: GalleryPresenterProtocol {
    
    private weak var view: GalleryView!
    private let router: GalleryRouter
    private var disposeBag = DisposeBag()
    
    init(_ view: GalleryView,
         _ router: GalleryRouter) {
        self.view = view
        self.router = router
    }
    
    func openTestDetail(image: UIImage, label: String, user: String, date: String, descr: String) {
        router.openTestDetail(image: image, label: label, user: user, date: date, descr: descr)
    }
}
