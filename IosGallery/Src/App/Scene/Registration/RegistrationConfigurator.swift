//
//  RegistrationConfigurator.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class RegistrationConfigurator {
    func configure(view: RegistrationViewController) {
        let router = RegistrationRouter(view)
        let presenter = RegistrationPresenterImp(view, router, DI.resolve())
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
        guard let view = R.storyboard.registration.registrationVC() else {
            return
        }
        RegistrationConfigurator().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }

    static func openModal(viewController: UIViewController) {
        guard let view = R.storyboard.registration.registrationVC() else {
            return
        }
        RegistrationConfigurator().configure(view: view)
        view.modalPresentationStyle = .fullScreen
        viewController.present(view, animated: false)
    }
}
