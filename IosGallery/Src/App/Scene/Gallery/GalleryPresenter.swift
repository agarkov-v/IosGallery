//
//  GalleryPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift

enum GalleryType {
    case new
    case popular
}

protocol GalleryView: BaseView {
    
    func reloadCollection()
    func endRefreshing()
    func showLoaderView()
    func showEmptyMessage(_ stubType: StubType)
    func clearBackgroundView()
}

protocol GalleryPresenter {
    
    var galleryItemsCount: Int { get }
    func viewDidLoad()
    func loadData(searchBy text: String?)
    func setupCell(cell: GalleryCellView, index: Int)
    func didSelectRow(at index: Int)
    func reloadData(searchBy text: String?)
    func reset()
    func changeSegment(index: Int, searchText: String?)
}

class GalleryPresenterImp: GalleryPresenter {

    var galleryItemsCount: Int {
        return galleryItems.count
    }
    
    private weak var view: GalleryView!
    private let router: GalleryRouter
    private var disposeBag = DisposeBag()
    private var galleryItems = [GalleryEntity]()
    private let galleryUseCase: GalleryUseCase
    private var galletyType: GalleryType = .new
    
    init(_ view: GalleryView,
         _ router: GalleryRouter,
         _ galleryUseCase: GalleryUseCase) {
        self.view = view
        self.router = router
        self.galleryUseCase = galleryUseCase
        subscribe()
    }
    
    func viewDidLoad() {
        loadData()
    }

    func setupCell(cell: GalleryCellView, index: Int) {
        cell.setupCell(item: galleryItems[index])
    }

    func didSelectRow(at index: Int) {
        router.openDetail(galleryItem: galleryItems[index])
    }
    
    func loadData(searchBy text: String? = nil) {
        if galleryItems.isEmpty {
            view.showLoaderView()
        }
        guard galleryUseCase.hasMorePage else { return }
        galleryUseCase.loadNewData(type: galletyType, searchBy: text)
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.view.endRefreshing()
                if text != nil {
                    if self.galleryItems.isEmpty {
                        self.view.showEmptyMessage(.notingFound)
                    } else {
                        self.view.clearBackgroundView()
                    }
                } else {
                    if self.galleryItems.isEmpty {
                        self.view.showEmptyMessage(.noData)
                    } else {
                        self.view.clearBackgroundView()
                    }
                }
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.view.showEmptyMessage(.badConnection)
                self.view.showErrorDialog(message: error.localizedDescription)
                self.view.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    func reloadData(searchBy text: String?) {
        reset()
        loadData(searchBy: text)
    }
    
    func reset() {
        galleryUseCase.reset()
        galleryItems.removeAll()
        view.reloadCollection()
    }

    func changeSegment(index: Int, searchText: String?) {
        if index == 0 {
            galletyType = .new
        } else if index == 1 {
            galletyType = .popular
        } else if index == 2 {
            // TODO: test images
        } else {
            debugPrint("GalletyPresenter changeSegmant invalid index")
        }
        reset()
        loadData(searchBy: searchText)
    }

    private func subscribe() {
        _ = self.galleryUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (galleryItems) in
                guard let self = self else { return }
                self.galleryItems = galleryItems
                self.view.reloadCollection()
            })
            .disposed(by: disposeBag)
    }
}
