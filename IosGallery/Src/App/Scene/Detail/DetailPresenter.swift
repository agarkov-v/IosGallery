//
//  DetailPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift

protocol DetailView: BaseView {

    func setupView(galleryItem: GalleryEntity)
    func updateUser(user: String)
}

protocol DetailPresenter {

    func viewDidLoad()
    func viewWillAppear()
}

class DetailPresenterImp: DetailPresenter {
    
    private weak var view: DetailView!
    private let router: DetailRouter
    private var disposeBag = DisposeBag()
    private let galleryItem: GalleryEntity
    private let userGateway: UserGateway
    private var userItem: UserEntity?
    
    init(_ view: DetailView,
         _ router: DetailRouter,
         _ galleryItem: GalleryEntity,
         _ userGateway: UserGateway) {
        self.view = view
        self.router = router
        self.galleryItem = galleryItem
        self.userGateway = userGateway
    }

    func viewDidLoad() {
        getUser()
    }

    func viewWillAppear() {
        setupView()
    }

    private func setupView() {
        view.setupView(galleryItem: galleryItem)
    }

    private func getUser() {
        guard let user = galleryItem.user, user != "" else {
            view.updateUser(user: "Unknown user".localization())
            return
        }
        let userId = user.replacingOccurrences(of: "/api/users/", with: "")
        print("|| userId \(userId)")
        userGateway.getUser(id: userId)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] user in
                self?.userItem = user
                self?.view.updateUser(user: user.username)
            }, onError: { error in
                debugPrint("DetailPresenter getUser \(error) || \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
