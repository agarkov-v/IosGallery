//
//  StubLoad.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 21.10.2020.
//

import UIKit

class StubLoad: UIView {
    
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.text = "Loading...".localization()
        }
    }
    
    func show() {
        activityIndicator.startAnimating()
    }
    
}
