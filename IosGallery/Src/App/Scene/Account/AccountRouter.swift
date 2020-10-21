//
//  AccountRouter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class AccountRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    init(_ view: AccountViewController) {
        self.view = view
    }
    
    func openAccountSettings() {
        AccountSettingsConfigurator.open(navigationController: view.navigationController!)
    }
}
