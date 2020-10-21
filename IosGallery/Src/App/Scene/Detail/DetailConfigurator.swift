//
//  DetailConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

class DetailConfigurator {
    
    func configure(view: DetailViewController) {
        let router = DetailRouter(view)
        let presenter = DetailPresenter(view, router)
        view.presenter = presenter
    }
    
    func testConfigure(view: DetailViewController, image: UIImage, label: String, user: String, date: String, descr: String) {
        let router = DetailRouter(view)
        let presenter = DetailPresenter(view, router)
        view.presenter = presenter
        view.testImage = image
        view.testLabel = label
        view.testUserName = user
        view.testDate = date
        view.testDescr = descr
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.detail.detailVC()!
        DetailConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
    
    static func testOpen(navigationController: UINavigationController, image: UIImage, label: String, user: String, date: String, descr: String) {
        let view = R.storyboard.detail.detailVC()!
        DetailConfigurator().testConfigure(view: view, image: image, label: label, user: user, date: date, descr: descr)
        navigationController.pushViewController(view, animated: true)
    }
}
