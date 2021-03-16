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

        layer.masksToBounds = false
        layer.cornerRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

        galleryImageView.layer.cornerRadius = radius
    }

    func setupCell(item: GalleryEntity) {
        let url = URL(string: "http://gallery.dev.webant.ru/media/" + item.image.name)
        galleryImageView.kf.indicatorType = .activity
        galleryImageView.kf.setImage(with: url)
    }

}
