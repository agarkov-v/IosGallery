//
//  AppError.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

enum AppError: LocalizedError {
    
    case loginPasswordError
    case tokenExpiredError
    case tokenRefreshingError
    
    case userDataError
    
    case imageToPngError
    
    var localizedDescription: String? {
        switch self {
        case .loginPasswordError:
            return "Invalid username or password".localization()
        case .tokenExpiredError:
            return "Authorization error, please try again".localization()
        case .tokenRefreshingError:
            return nil
        case .userDataError:
            return "User data error, please try again".localization()
        case .imageToPngError:
            return "Image processing error".localization()
        }
    }
}
