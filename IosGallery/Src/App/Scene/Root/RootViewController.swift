//
//  RootViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class RootViewController: UITabBarController {

    var presenter: RootPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        RootConfigurator().configure(view: self)
    }
}

extension RootViewController: RootView {
    
}

extension RootViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard tabBarController.selectedViewController === viewController else { return true }
        guard let navigationController = viewController as? UINavigationController else {
            assertionFailure()
            return true
        }
        if navigationController.viewControllers.count <= 1, let destinationViewController = navigationController.viewControllers.first as? ScrollableToTop {
            destinationViewController.scrollToTop()
            return false
            
        } else if navigationController.viewControllers.count <= 1, let destinationViewController = navigationController.viewControllers.first?.children[0] as? ScrollableToTop {
            //for VC in Containetr
            destinationViewController.scrollToTop()
            return false
        }
        return true
    }
}

