//
//  AccountConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

class AccountConfigurator {
    
    func configure(view: AccountViewController) {
        let router = AccountRouter(view)
        let presenter = AccountPresenterImp(view, router)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.account.accountVC()!
        AccountConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
