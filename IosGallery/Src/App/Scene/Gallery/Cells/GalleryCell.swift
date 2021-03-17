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
        layer.borderWidth = 1
        layer.borderColor = R.color.blackWhite()?.cgColor

        galleryImageView.layer.cornerRadius = radius
    }

    func setupCell(item: GalleryEntity) {
        galleryImageView.kf.indicatorType = .activity
        if item.image.name == "testPlaceholderImage" {
            galleryImageView.image = UIImage(named: item.image.name)
        } else {
            let url = URL(string: "http://gallery.dev.webant.ru/media/" + item.image.name)
            galleryImageView.kf.setImage(with: url)
        }
    }

}
