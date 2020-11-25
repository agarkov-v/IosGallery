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
    
}
