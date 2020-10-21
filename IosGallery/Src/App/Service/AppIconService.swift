//
//  AppIconService.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.10.2020.
//

import UIKit

class AppIconService {
    
    let application = UIApplication.shared
    
    enum AppIcon: String {
        case iconPrimary
        case iconDark
    }
    
    func changeAppIcon(to appIcon: AppIcon) {
        let appIconValue: String? = appIcon == .iconPrimary ? nil : appIcon.rawValue
        application.setAlternateIconName(appIconValue) { (error) in
            if error != nil {
                print("Error localized is: \(error?.localizedDescription) \nand error: \(error)")
            }
        }
    }
}
