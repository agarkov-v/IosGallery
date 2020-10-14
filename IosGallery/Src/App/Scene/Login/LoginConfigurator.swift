//
//  LoginConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import Foundation
import UIKit

class LoginConfigurator {
    func configure(view: LoginViewController) {
        let router = LoginRouter(view)
        let presenter = LoginPresenter(view, router)
        view.presenter = presenter
        
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.login.loginVC()!
        LoginConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
