//
//  ImportRouter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class ImportRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    init(_ view: ImportViewController) {
        self.view = view
    }
    
}
