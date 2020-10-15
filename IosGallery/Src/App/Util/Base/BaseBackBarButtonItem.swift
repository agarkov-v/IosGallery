//
//  BaseBackBarButtonItem.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 15.10.2020.
//

import Foundation
import UIKit

// Way to ignore iOS 14 long tap
class BaseBackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        get {
            return super.menu
        }
        set {
            // This is necessary because this way we ignore ios14 setting the menu property at all
        }
    }
}
