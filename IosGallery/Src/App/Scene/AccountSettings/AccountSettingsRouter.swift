//
//  AccountSettingsRouter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class AccountSettingsRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    init(_ view: AccountSettingsViewController) {
        self.view = view
    }
    
}
