//
//  AccountSettingsConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

class AccountSettingsConfigurator {
    
    func configure(view: AccountSettingsViewController) {
        let router = AccountSettingsRouter(view)
        let presenter = AccountSettingsPresenterImp(view, router, DI.resolve(), DI.resolve())
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.accountSettings.accountSettingsVC()!
        AccountSettingsConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
