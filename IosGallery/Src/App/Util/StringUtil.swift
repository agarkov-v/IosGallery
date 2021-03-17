//
//  StringUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation

extension String {
    
    func localization() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func trimming(characterSet: CharacterSet = .whitespacesAndNewlines) -> String? {
        let trimText = trimmingCharacters(in: characterSet)
        if trimText == "" {
            return nil
        } else {
            return trimText
        }
    }
}
