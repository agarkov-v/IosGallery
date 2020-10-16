//
//  GalleryCell.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class GalleryCell: UICollectionViewCell {

    @IBOutlet weak var galleryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.75
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale

        galleryImageView.layer.cornerRadius = 8
    }
    

}
