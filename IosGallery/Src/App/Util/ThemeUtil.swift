//
//  ThemeUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 16.03.2021.
//

import Foundation
import UIKit

enum Theme: Int, CaseIterable {
    case system
    case light
    case dark
}

extension Theme {

    // Обертка для UserDefaults
    @Persist(key: "app_theme", defaultValue: Theme.light.rawValue)
    private static var appTheme: Int

    // Сохранение темы в UserDefaults
    func save() {
        Theme.appTheme = rawValue
    }

    // Текущая тема приложения
    static var current: Theme {
        Theme(rawValue: appTheme) ?? .light
    }
}

extension Theme {
    @available(iOS 13.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return .unspecified
        }
    }

    func setActive() {
        save()

        guard #available(iOS 13.0, *) else { return }
        UIApplication.shared.windows
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}

@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
