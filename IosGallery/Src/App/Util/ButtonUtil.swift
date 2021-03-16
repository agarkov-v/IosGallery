//
//  ButtonUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

extension UIButton {

    func setIcon(_ icon: UIImage?) {
        imageView?.contentMode = .scaleAspectFit
        setImage(nil, for: UIControl.State())

        guard let imageView = imageView else { return }

        UIView.transition(with: imageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.setImage(icon, for: .normal)
                          },
                          completion: nil)
    }
}
