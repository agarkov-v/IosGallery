//
//  TextFieldUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

extension UITextField {

    func setRightViewIcon(icon: UIImage) {
        let buttonView = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * 0.70), height: ((self.frame.height) * 0.70)))

        buttonView.setImage(icon.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        buttonView.tintColor = .lightGray
        
        self.rightViewMode = .always
        self.rightView = buttonView
        
        buttonView.addTarget(self, action: #selector(isSecure(button:) ), for: .touchUpInside)
    }
    
    @objc func isSecure(button: UIButton) {
        self.isSecureTextEntry.toggle()
        
        if button.tintColor == .lightGray {
//            button.tintColor = UIColor(red: 0.465, green: 0.166, blue: 0.952, alpha: 1)
            button.tintColor = R.color.pink()
        } else {
            button.tintColor = .lightGray
        }
    }
}
