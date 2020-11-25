//
//  NavigationCustomizationUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 15.10.2020.
//

import UIKit

enum NavigationType {
    case gallery
    case uploadImage
    case accountGallery
    
    var title: String {
        switch self {
        case .gallery:        return "Gallery".localization()
        case .uploadImage:  return "Upload Image".localization()
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
    
    func setupTitleNavigationBar(entity: NavigationType? = nil, _ customString: String = "") {
        var title: String
        let image = R.image.arrowLeft()
        let tintColor = R.color.whiteDark()

        if let entity = entity {
            title = entity.title
        } else {
            title = customString
        }
        navVC?.navigationBar.topItem?.title = title
        navVC?.navigationBar.isTranslucent = true
        self.navigationItem.title = title
        navVC?.navigationBar.tintColor = tintColor
        navVC?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        ]

        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.setBackIndicatorImage(image, transitionMaskImage: image)
            navVC?.navigationBar.backIndicatorImage = image
            navVC?.navigationBar.backIndicatorTransitionMaskImage = image
        } else {
            navVC?.navigationBar.backIndicatorImage = image
            navVC?.navigationBar.backIndicatorTransitionMaskImage = image
        }
        if #available(iOS 14.0, *) {
            self.addBackBarButtonOnNavigationBar()
        }

    }
    
    func addBackBarButtonOnNavigationBar() {
        let backImage: UIImage = UIImage()
        let backBtn: BaseBackBarButtonItem = BaseBackBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonAction))
        backBtn.tintColor = R.color.whiteDark()
        backBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)], for: .normal)
        navigationItem.backBarButtonItem = backBtn

    }
    
    @objc func backButtonAction() {
        self.navigationController!.popViewController(animated: true)
    }
    
    func addBackBarButtonOnNavigationBar(action: Selector, entity: NavigationType? = nil, _ customString: String = "") {
        let image = R.image.arrowLeft()
        let tintColor = R.color.whiteDark()
        var title: String
        if let entity = entity {
            title = entity.title
        } else {
            title = customString
        }
        
        navVC?.navigationBar.topItem?.title = title
        self.navigationItem.title = title
        navVC?.navigationBar.isTranslucent = true
        
        let backBtn: BaseBackBarButtonItem = BaseBackBarButtonItem(image: image, style: .plain, target: self, action: action)
        backBtn.tintColor = tintColor
        backBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)], for: .normal)
        navigationItem.backBarButtonItem = backBtn
    }
    
    func setupActionLeftButton(action: Selector) {
        let image = R.image.arrowLeft()
        let tintColor = R.color.whiteDark()
        let edgeInsets = UIEdgeInsets(top: -1, left: -8, bottom: 0, right: 0)
        
        navVC?.navigationBar.isTranslucent = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: action)
        self.navigationItem.leftBarButtonItem?.tintColor = tintColor
        self.navigationItem.leftBarButtonItem?.imageInsets = edgeInsets
    }
    
    func setupDefaultNavigationBar() {
        let title = "Gallery"
        let image = R.image.arrowLeft()
        let tintColor = R.color.whiteDark()
        
        navVC?.navigationBar.tintColor = tintColor
        navVC?.navigationBar.backIndicatorImage = image
        navVC?.navigationBar.backIndicatorTransitionMaskImage = image
        
        navVC?.navigationBar.topItem?.title = title.localization()
        self.navigationItem.title = title.localization()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navVC?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        ]
        // removed ios 14 long tap
        if #available(iOS 14.0, *) {
            addBackBarButtonOnNavigationBar()
        }
    }
}
