//
//  CollectionViewUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 21.10.2020.
//

import UIKit

extension UICollectionView {
    
    func stubView(stubType: StubType? = nil, image: UIImage? = nil, title: String = "", message: String = "", take header: CGRect? = nil) {
        let sizes: CGSize = bounds.size
        
        let nib = R.nib.stubView
        guard let backgroundView = nib.instantiate(withOwner: nil)[0] as? StubView else { return }
        
        let rect = header != nil ? CGRect(x: 0,
                                          y: header!.maxY,
                                          width: sizes.width,
                                          height: sizes.height - header!.height) : CGRect(x: 0.0,
                                                                                          y: 0.0,
                                                                                          width: sizes.width,
                                                                                          height: sizes.height)
        
        let container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: sizes.width, height: sizes.height))
        backgroundView.frame = rect
        container.addSubview(backgroundView)
        
        if let stubType = stubType {
            backgroundView.setup(stubType)
        } else {
            backgroundView.setup(image ?? R.image.notFoundPlaceholder()!, title, message)
        }
        
        self.backgroundView = container
    }
    
    func stubLoading(take header: CGRect? = nil) {
        let sizes: CGSize = bounds.size
        let nib = R.nib.stubLoad
        guard let backgroundView = nib.instantiate(withOwner: nil)[0] as? StubLoad else { return }
        
        let rect = header != nil ? CGRect(x: 0,
                                          y: header!.maxY,
                                          width: sizes.width,
                                          height: sizes.height - header!.height) : CGRect(x: 0.0,
                                                                                          y: 0.0,
                                                                                          width: sizes.width,
                                                                                          height: sizes.height)
        
        let container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: sizes.width, height: sizes.height))
        backgroundView.frame = rect
        container.addSubview(backgroundView)
        self.backgroundView = container
    }
    
    func hideEmptyMessage() {
        backgroundView = nil
    }
}
