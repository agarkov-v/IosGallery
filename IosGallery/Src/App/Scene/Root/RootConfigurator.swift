//
//  RootConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

class RootConfigurator {
    
    func configure(view: RootViewController) {
        let router = RootRouter(view)
        let presenter = RootPresenter(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.root.rootVC()!
        RootConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
