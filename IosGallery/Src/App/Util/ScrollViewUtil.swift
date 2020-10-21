//
//  ScrollViewUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 21.10.2020.
//

import UIKit

protocol ScrollableToTop {
    func scrollToTop()
}

extension UIScrollView {
    func scrollToTop(_ animated: Bool) {
        var topContentOffset: CGPoint
        if #available(iOS 11.0, *) {
            topContentOffset = CGPoint(x: -safeAreaInsets.left, y: -safeAreaInsets.top)
        } else {
            topContentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
        }
        setContentOffset(topContentOffset, animated: animated)
    }
}
