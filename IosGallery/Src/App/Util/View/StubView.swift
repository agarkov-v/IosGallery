//
//  StubView.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 21.10.2020.
//

import UIKit

enum StubType {
    case noData
    case badConnection
    case notingFound
    
    static func getImage(_ type: StubType) -> UIImage {
        switch type {
        case .noData: return R.image.badConnectionPlaceholder()!
        case .badConnection: return R.image.badConnectionPlaceholder()!
        case .notingFound: return R.image.notFoundPlaceholder()!
        }
    }
    
    static func getTitle(_ type: StubType) -> String {
        switch type {
        case .noData: return "Wow!".localization()
        case .badConnection: return "Oops!".localization()
        case .notingFound: return "Sorry!".localization()
        }
    }
    
    static func getMessage(_ type: StubType) -> String {
        switch type {
        case .noData: return "There is no pictures yet".localization()
        case .badConnection: return "Bad connection. Please check your connection and reload the page.".localization()
        case .notingFound: return "Nothing found.".localization()
        }
    }
}

class StubView: UIView {
    
    @IBOutlet weak var stubImage: UIImageView!
    @IBOutlet weak var stubTitle: UILabel!
    @IBOutlet weak var stubMessage: UILabel!
    
    func setup(_ image: UIImage, _ title: String, _ message: String) {
        let textColor = R.color.inactiveGray()!
        stubImage.image = image
        stubTitle.text = title
        stubMessage.text = message
        
        stubTitle.textColor = textColor
        stubMessage.textColor = textColor
        
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    func setup(_ type: StubType) {
        let textColor = R.color.inactiveGray()!
        stubImage.image = StubType.getImage(type)
        stubTitle.text = StubType.getTitle(type)
        stubMessage.text = StubType.getMessage(type)
        
        stubTitle.textColor = textColor
        stubMessage.textColor = textColor
        
        setNeedsDisplay()
        setNeedsLayout()
    }
}
