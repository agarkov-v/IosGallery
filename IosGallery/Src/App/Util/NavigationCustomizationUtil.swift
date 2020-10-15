//
//  NavigationCustomizationUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 15.10.2020.
//

import UIKit

enum NavigationType {
    case gallery
    case exportImage
    case accountGallery

    
    var title: String {
        switch self {
        case .gallery:        return "Gallery".localization()
        case .exportImage:  return "Import".localization()
        case .accountGallery:    return "Account Gallery".localization()
        }
    }
    
}

extension UIViewController {
    
    var navVC: UINavigationController? {
        guard let navVC = self as? UINavigationController else {
            return self.navigationController
        }
        return navVC
    }
    
    func setupTitleNavigationBar(entity: NavigationType) {
        let title = entity.title

        navVC?.navigationBar.topItem?.title = title
        self.navigationItem.title = title
        // removed ios 14 long tap
        if #available(iOS 14.0, *) {
            addBackBarButtonOnNavigationBar()
        } else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        navVC?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        ]
        navVC?.navigationBar.tintColor = .black
        
        
        let backButtonBackgroundImage = R.image.arrowLeft()
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.setBackIndicatorImage(backButtonBackgroundImage, transitionMaskImage: backButtonBackgroundImage)
        } else {
            navVC?.navigationBar.backIndicatorImage = backButtonBackgroundImage
            navVC?.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        }
    }
    
    func addBackBarButtonOnNavigationBar() {
        let backBtn: BaseBackBarButtonItem = BaseBackBarButtonItem(image: R.image.arrowLeft(), style: .plain, target: self, action: #selector(backButtonAction))
        backBtn.tintColor = .black
        backBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)], for: .normal)
        navigationItem.backBarButtonItem = backBtn
    }
    
    @objc func backButtonAction() {
        self.navigationController!.popViewController(animated: true)
    }

    
    func setupTitleNavigationBar(title: String) {
        let locTitle = title.localization()
        navVC?.navigationBar.topItem?.title = locTitle
        self.navigationItem.title = locTitle
        // removed ios 14 long tap
        if #available(iOS 14.0, *) {
            addBackBarButtonOnNavigationBar()
        } else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navVC?.navigationBar.tintColor = .black
        navVC?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        ]
        
        let backButtonBackgroundImage = R.image.arrowLeft()
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.setBackIndicatorImage(backButtonBackgroundImage, transitionMaskImage: backButtonBackgroundImage)
        } else {
            navVC?.navigationBar.backIndicatorImage = backButtonBackgroundImage
            navVC?.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        }
    }
    
    func setupActionBackButton(action: Selector) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.arrowLeft(), style: .done, target: self, action: action)
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: -1, left: -8, bottom: 0, right: 0)
    }
    
    func setupDefaultNavigationBar() {
        let title = "Gallery"
        
        navVC?.navigationBar.topItem?.title = title.localization()
        self.navigationItem.title = title.localization()
        // removed ios 14 long tap
        if #available(iOS 14.0, *) {
            addBackBarButtonOnNavigationBar()
        } else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navVC?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        ]
        navVC?.navigationBar.tintColor = .black
        navVC?.navigationBar.backIndicatorImage = R.image.arrowLeft()
        navVC?.navigationBar.backIndicatorTransitionMaskImage = R.image.arrowLeft()
    }
}
