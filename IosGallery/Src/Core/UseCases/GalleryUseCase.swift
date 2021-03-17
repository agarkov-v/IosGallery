//
//  GalleryUseCase.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation
import RxSwift

protocol GalleryUseCase {
    
    var source: PublishSubject<[GalleryEntity]> { get }
    
    var hasMorePage: Bool { get }
    
    func getCurrentPage() -> Int
    func loadNewData(type: GalleryType, searchBy text: String?) -> Completable
    func reset()
}

class GalleryUseCaseImp: GalleryUseCase {
    
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
    
    init (gateway: GalleryGateway) {
        self.gateway = gateway
    }
    
    func getCurrentPage() -> Int {
        return currentPage
    }
    
    func loadNewData(type: GalleryType, searchBy text: String? = nil) -> Completable {
        return .deferred {
            self.isLoadingInProcess = true
            
            return self.gateway.getPhotos(page: self.currentPage + 1, limit: self.limit, type: type, searchBy: text)
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

