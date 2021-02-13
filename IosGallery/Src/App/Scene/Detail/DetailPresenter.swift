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

    func setipView(galleryItem: GalleryEntity)
}

protocol DetailPresenter {

    func viewDidLoad()
}

class DetailPresenterImp: DetailPresenter {
    
    private weak var view: DetailView!
    private let router: DetailRouter
    private var disposeBag = DisposeBag()
    private let galleryItem: GalleryEntity
    
    init(_ view: DetailView,
         _ router: DetailRouter,
         _ galleryItem: GalleryEntity) {
        self.view = view
        self.router = router
        self.galleryItem = galleryItem
    }

    func viewDidLoad() {
        setupView()
    }

    func setupView() {
        view.setipView(galleryItem: galleryItem)
    }
}
