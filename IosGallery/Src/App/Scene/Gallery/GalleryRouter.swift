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
    
    func openTestDetail(image: UIImage, label: String, user: String, date: String, descr: String) {
        DetailConfigurator.testOpen(navigationController: view.navigationController!, image: image, label: label, user: user, date: date, descr: descr)
    }
    
}
