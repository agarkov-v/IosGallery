//
//  RegistrationRouter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class RegistrationRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    init(_ view: RegistrationViewController) {
        self.view = view
    }
    
    func closeModal() {
        dismiss()
    }
}
