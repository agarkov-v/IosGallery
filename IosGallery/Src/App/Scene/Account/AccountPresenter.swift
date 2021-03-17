//
//  AccountPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift

protocol AccountView: BaseView {
    
    func reloadTable()
    func endRefreshing()
    func showLoaderView()
    func showEmptyMessage(_ stubType: StubType)
    func clearBackgroundView()
    func setupProfile(user: UserEntity)
}

protocol AccountPresenter {

    func viewDidLoad()
    func viewWillAppear()
    func reloadData()
    var galleryItemsCount: Int { get }
    func openAccountSettings()
    func selectImage(index: Int)
    func setupCell(cell: AccountCellView, index: Int)
}

class AccountPresenterImp: AccountPresenter {
    
    private weak var view: AccountView!
    private let router: AccountRouter
    private var disposeBag = DisposeBag()
    private let accountUseCase: AccountUseCase
    private var galleryItems = [GalleryEntity]()
    private let userManager: UserManager
    
    var galleryItemsCount: Int {
        galleryItems.count
    }
    
    init(_ view: AccountView,
         _ router: AccountRouter,
         _ accountUseCase: AccountUseCase,
         _ userManager: UserManager) {
        self.view = view
        self.router = router
        self.accountUseCase = accountUseCase
        self.userManager = userManager
        subscribe()
    }
    
    func openAccountSettings() {
        router.openAccountSettings()
    }
    
    func selectImage(index: Int) {
        router.openDetail(galleryItem: galleryItems[index])
    }
    
    func setupCell(cell: AccountCellView, index: Int) {
        cell.setupCell(item: galleryItems[index])
    }
    
    func viewDidLoad() {
        loadData()
    }

    func viewWillAppear() {
        getUser()
    }
    
    func reloadData() {
        accountUseCase.reset()
        loadData()
    }

    private func subscribe() {
        accountUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (items) in
                guard let self = self else { return }
                self.galleryItems = items
                self.view.reloadTable()
            })
            .disposed(by: disposeBag)
    }

    private func loadData() {
        if galleryItems.isEmpty {
            view.showLoaderView()
        }
        guard accountUseCase.hasMorePage else { return }
        accountUseCase.loadNewData()
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.view.endRefreshing()
                if self.galleryItems.isEmpty {
                    self.view.showEmptyMessage(.noData)
                } else {
                    self.view.clearBackgroundView()
                }
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.view.showEmptyMessage(.badConnection)
                self.view.showErrorDialog(message: error.localizedDescription)
                self.view.endRefreshing()
            })
            .disposed(by: disposeBag)
    }

    private func getUser() {
        if let user = userManager.user {
            view.setupProfile(user: user)
        }
    }
}
