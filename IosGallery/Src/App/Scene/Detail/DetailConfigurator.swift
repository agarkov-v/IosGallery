//
//  DetailConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

class DetailConfigurator {

    func configure(view: DetailViewController, galleryItem: GalleryEntity) {
        let router = DetailRouter(view)
        let presenter = DetailPresenterImp(view, router, galleryItem, DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController, galleryItem: GalleryEntity) {
        let view = R.storyboard.detail.detailVC()!
        DetailConfigurator().configure(view: view, galleryItem: galleryItem)
        navigationController.pushViewController(view, animated: true)
    }
}
