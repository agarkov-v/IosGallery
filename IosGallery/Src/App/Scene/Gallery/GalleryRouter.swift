//
//  GalleryRouter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class GalleryRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    init(_ view: GalleryViewController) {
        self.view = view
    }

    func openDetail(galleryItem: GalleryEntity) {
        DetailConfigurator.open(navigationController: self.view.navigationController!, galleryItem: galleryItem)
    }
    
}
