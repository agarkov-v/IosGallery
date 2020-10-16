//
//  UIViewControllerAllerts.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 16.10.2020.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String? = nil, firstActionTitle: String? = nil, secondActionTitle: String? = nil, firstCompletion: (() -> Void)? = nil, secondCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
                secondCompletion?()
            }
            alertController.addAction(secondAction)
        }
        
        let firstAction = UIAlertAction(title: firstActionTitle ?? "Ok".localization(), style: .default) { (action) in
            firstCompletion?()
        }
        alertController.addAction(firstAction)
        self.present(alertController, animated: true)
    }
    
    
    func showActionSheetAlert(title: String? = nil, message: String? = nil, firstActionTitle: String? = nil, secondActionTitle: String? = nil, thirdActionTitle: String? = nil, firstCompletion: (() -> Void)? = nil, secondCompletion: (() -> Void)? = nil, thirdCompletion: (()->())? = nil, fourthActionTitle: String? = nil, fourthCompletion: (()->())? = nil,  cancelCompletion: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        
        let firstAction = UIAlertAction(title: firstActionTitle ?? "Ok".localization(), style: .default) { (action) in
            firstCompletion?()
        }
        alertController.addAction(firstAction)
        
        if let secondActionTitle = secondActionTitle {
            let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
                secondCompletion?()
            }
            alertController.addAction(secondAction)
        }
        
        if let thirdActionTitle = thirdActionTitle {
            let thirdAction = UIAlertAction(title: thirdActionTitle, style: .default) { (action) in
                thirdCompletion?()
            }
            alertController.addAction(thirdAction)
        }
        
        if let fourthActionTitle = fourthActionTitle {
            let fourthAction = UIAlertAction(title: fourthActionTitle, style: .default) { (action) in
                fourthCompletion?()
            }
            alertController.addAction(fourthAction)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel".localization(), style: .cancel, handler: { action in
            cancelCompletion?()
        }))
        
        self.present(alertController, animated: true)
    }
    
    func showTimingAlert(message: String?) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        present(alertController, animated: true, completion: {
            let _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
                alertController.dismiss(animated: true, completion: nil)
            })
        })
    }
}

