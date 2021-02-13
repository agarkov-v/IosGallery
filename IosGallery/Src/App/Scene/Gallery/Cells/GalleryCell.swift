//
//  GalleryCell.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit
import Kingfisher

protocol GalleryCellView {

    func setupCell(item: GalleryEntity)
}

class GalleryCell: UICollectionViewCell, GalleryCellView {

    @IBOutlet weak var galleryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.galleryImageView.kf.cancelDownloadTask()
        self.galleryImageView.image = nil
    }
    
    func setupShadow() {
        let radius: CGFloat = 8
        let shadowOpacity: Float = 0.7
        let bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: radius, height: radius))
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = bezierPath.cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale

        galleryImageView.layer.cornerRadius = radius
    }

    func setupCell(item: GalleryEntity) {
        let url = URL(string: "http://gallery.dev.webant.ru/media/" + item.image.name)
        self.galleryImageView.kf.indicatorType = .activity
        self.galleryImageView.kf.setImage(with: url)
    }

}
