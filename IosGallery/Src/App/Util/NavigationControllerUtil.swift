//
//  NavigationControllerUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        
        self.popViewController(animated: animated)
        self.transitionCoordinator?.animate(alongsideTransition: nil) { _ in
            completion()
        }
    }
}

// MARK: - Hiding Back Button

extension UINavigationItem {
    
    /// A Boolean value that determines whether the back button is hidden.
    ///
    /// When set to `true`, the back button is hidden when this navigation item
    /// is the top item. This is true regardless of the value in the
    /// `leftItemsSupplementBackButton` property. When set to `false`, the back button
    /// is shown if it is still present. (It can be replaced by values in either
    /// the `leftBarButtonItem` or `leftBarButtonItems` properties.) The default value is `false`.
    @IBInspectable var hideBackButton: Bool {
        get { hidesBackButton }
        set { hidesBackButton = newValue }
    }
}
