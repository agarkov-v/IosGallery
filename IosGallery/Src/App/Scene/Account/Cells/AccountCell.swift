//
//  AccountCell.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit
import Kingfisher

protocol AccountCellView {

    func setupCell(item: GalleryEntity)
}

class AccountCell: UITableViewCell, AccountCellView {

    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        accountImageView.kf.cancelDownloadTask()
        accountImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        accountView.layer.cornerRadius = 4
        accountImageView.layer.cornerRadius = 8
    }

    func setupCell(item: GalleryEntity) {
        let url = URL(string: "http://gallery.dev.webant.ru/media/" + item.image.name)
        accountImageView.kf.indicatorType = .activity
        accountImageView.kf.setImage(with: url)
        nameLabel.text = item.name
        descriptionLabel.text = item.description
    }
    
}
