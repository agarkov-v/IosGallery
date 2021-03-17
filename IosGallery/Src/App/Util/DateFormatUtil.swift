//
//  DateFormatUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation

class DateFormatUtil {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM. yyyy, HH:mm"
        return formatter
    }()

    private static let hardDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    private static let customFormatter: DateFormatter = DateFormatter()
    
    static func customDateFormat(time: TimeInterval, format: String) -> String {
        customFormatter.dateFormat = format
        return customFormatter.string(from: Date(timeIntervalSince1970: time))
    }
    
    static func customDateFormat(dateString: String, format: String) -> String? {
        if let date = hardDateFormatter.date(from: dateString) {
            return customDateFormat(time: date.timeIntervalSince1970, format: format)
        } else { return nil }
    }

    static func standartDateFormat(dateString: String) -> String? {
        if let date = hardDateFormatter.date(from: dateString) {
            let format = "dd.MM.yyyy"
            return customDateFormat(time: date.timeIntervalSince1970, format: format)
        } else { return nil }
    }
    
    static func simpleDateFormat(time: TimeInterval) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: time))
    }
    
    static func simpleDateFormat(dateString: String) -> String? {
        if let date = hardDateFormatter.date(from: dateString) {
            return simpleDateFormat(time: date.timeIntervalSince1970)
        } else { return nil }
    }

    static func convertStringToDate(stringDate: String, isSmpleFormat: Bool = true) -> Date? {
        let format = isSmpleFormat ? "dd.MM.yyyy" : "yyyy-MM-dd'T'HH:mm:ssZ"
        customFormatter.dateFormat = format
        let date = customFormatter.date(from: stringDate)
        return date
    }

    static func convertDateToStandartString(date: Date) -> String {
        let format = "dd.MM.yyyy"
        customFormatter.dateFormat = format
        let dateString = customFormatter.string(from: date)
        return dateString
    }
}
