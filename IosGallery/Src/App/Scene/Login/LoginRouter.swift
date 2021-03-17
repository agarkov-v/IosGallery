//
//  LoginRouter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class LoginRouter: BaseRouter {

    weak var view: UIViewController!
    
    init(_ view: LoginViewController) {
        self.view = view
    }

    func openRootScreen() {
        let rootView = R.storyboard.root.rootVC()!
        guard let optWindow = UIApplication.shared.delegate?.window, let window = optWindow else { return }
        window.rootViewController = rootView
    }

    func openRegistrationScreen() {
        RegistrationConfigurator.openModal(viewController: view)
    }
}
