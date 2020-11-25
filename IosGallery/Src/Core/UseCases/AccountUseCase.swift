//
//  AccountUseCase.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation
import RxSwift

protocol AccountUseCase {
    
    var source: PublishSubject<[GalleryEntity]> { get }
    //var limit: Int { get set }
    //var isLoadingInProcess: Bool { get }
    
    var hasMorePage: Bool { get }
    
    func getCurrentPage() -> Int
    func loadNewData() -> Completable
    func reset()
}

class AccountUseCaseImp: AccountUseCase {
    
    let manager: UserManager
    let gateway: GalleryGateway
    var source = PublishSubject<[GalleryEntity]>()
    
    private var limit = 10
    private var currentPage = 0
    private var countOfPages: Int?
    private var isLoadingInProcess = false
    private var items = [GalleryEntity]()
    
    var hasMorePage: Bool {
        if self.isLoadingInProcess {
            return false
        }
        guard let countOfPages = self.countOfPages else {
            return true
        }
        return self.currentPage < countOfPages
    }
    
    init (manager: UserManager, gateway: GalleryGateway) {
        self.manager = manager
        self.gateway = gateway
    }
    
    func getCurrentPage() -> Int {
        return self.currentPage
    }
    
    func loadNewData() -> Completable {
        return .deferred {
            self.isLoadingInProcess = true
            
            guard let userId = self.manager.user?.id else {
                // show error with reauth screen segue
                return .error(AppError.userDataError)
            }
            
            return self.gateway.getUserPhotos(page: self.currentPage + 1, limit: self.limit, userId: userId)
                .do(onSuccess: { (result: PaginationEntity<GalleryEntity>) in
                    self.currentPage += 1
                    self.countOfPages = result.countOfPages
                    self.items.append(contentsOf: result.data)
                    self.isLoadingInProcess = false
                    self.source.onNext(self.items)
                }, onError: { error in
                    self.isLoadingInProcess = false
                    print(error)
                })
                .asCompletable()
        }
    }
    
    func reset() {
        self.items.removeAll()
        self.currentPage = 0
        self.countOfPages = nil
        self.isLoadingInProcess = false
    }
}

