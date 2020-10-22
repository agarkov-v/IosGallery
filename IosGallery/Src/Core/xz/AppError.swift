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
            return "Неправильная пара логин пароль"
        case .tokenExpiredError:
            return "Ошибка авторизации, попробуйте повторить действие"
        case .tokenRefreshingError:
            return nil
        case .userDataError:
            return "Ошибка данных пользователя, попробуйте повторить действие"
        case .imageToPngError:
            return "Ошибка обработки изображения"
        }
    }
}
