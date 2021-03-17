//
//  GalleryConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

class GalleryConfigurator {
    
    func configure(view: GalleryViewController) {
        let router = GalleryRouter(view)
        let presenter = GalleryPresenterImp(view, router, DI.resolve())
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.gallery.galleryVC()!
        GalleryConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
