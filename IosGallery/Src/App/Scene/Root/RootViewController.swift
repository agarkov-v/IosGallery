//
//  RootViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class RootViewController: UITabBarController {

    var presenter: RootPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension RootViewController: RootView {
    
}
