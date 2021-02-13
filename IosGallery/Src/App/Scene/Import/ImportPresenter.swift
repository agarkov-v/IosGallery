//
//  ImportPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift

protocol ImportView: BaseView {

    func cleanView()
}

protocol ImportPresenter {

    func importImage(image: UIImage, name: String, description: String)
}

class ImportPresenterImp: ImportPresenter {
    
    private weak var view: ImportView!
    private let router: ImportRouter
    private var disposeBag = DisposeBag()
    private let userUseCase: UserUseCase
    
    init(_ view: ImportView,
         _ router: ImportRouter,
         _ userUseCase: UserUseCase) {
        self.view = view
        self.router = router
        self.userUseCase = userUseCase
    }

    func importImage(image: UIImage, name: String, description: String) {
        userUseCase.uploadGalleryItem(image: image, name: name, description: description)
            .observeOn(MainScheduler.instance)
            .do(onSubscribed: { [weak self] in
                guard let self = self else { return }
                self.view.showActivityIndicator()
            }, onDispose: { [weak self] in
                guard let self = self else { return }
                self.view.hideActivityIndicator()
            })
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.view.showDialog(message: "Image is successfully loaded ")
                self.view.cleanView()
            }, onError: { [weak self] error in
                guard let self = self else { return }
                debugPrint("importImage error: \(error) || \(error.localizedDescription)")
                self.view.showErrorDialog(message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

