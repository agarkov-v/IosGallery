//
//  ImportConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

class ImportConfigurator {
    
    func configure(view: ImportViewController) {
        let router = ImportRouter(view)
        let presenter = ImportPresenter(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.import.importVC()!
        ImportConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
