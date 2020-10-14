//
//  ButtonUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

extension UIButton {

    func setIcon(_ icon: UIImage?) {
        self.imageView?.contentMode = .scaleAspectFit
        self.setImage(nil, for: UIControl.State())

        guard let imageView = self.imageView else {
            return
        }

        UIView.transition(with: imageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { self.setImage(icon, for: .normal) },
                          completion: nil)
    }
}
