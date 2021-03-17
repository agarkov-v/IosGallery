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
        if isLoadingInProcess {
            return false
        }
        guard let countOfPages = countOfPages else {
            return true
        }
        return currentPage < countOfPages
    }
    
    init (manager: UserManager, gateway: GalleryGateway) {
        self.manager = manager
        self.gateway = gateway
    }
    
    func getCurrentPage() -> Int {
        return currentPage
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
        items.removeAll()
        currentPage = 0
        countOfPages = nil
        isLoadingInProcess = false
    }
}

