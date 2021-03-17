//
//  DetailRouter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class DetailRouter: BaseRouter {
    
    weak var view: UIViewController!
    
    init(_ view: DetailViewController) {
        self.view = view
    }
}
