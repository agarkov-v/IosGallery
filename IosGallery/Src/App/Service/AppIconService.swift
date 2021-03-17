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
            guard error != nil else { return }
            print("Error localized is: \(String(describing: error?.localizedDescription)) | and error: \(String(describing: error))")
        }
    }
}
