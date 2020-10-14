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
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.detail.detailVC()!
        DetailConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
