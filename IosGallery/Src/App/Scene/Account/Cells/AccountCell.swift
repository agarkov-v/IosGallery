//
//  AccountCell.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descriptionLabel.contentMode = .top
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3
        accountImageView.layer.cornerRadius = 8
        accountImageView.layer.shadowColor = R.color.inactiveGray()!.cgColor
        accountImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        accountImageView.layer.shadowRadius = 4
        accountImageView.layer.shadowOpacity = 0.75
        accountImageView.layer.masksToBounds = false
        accountImageView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        accountImageView.layer.shouldRasterize = true
        accountImageView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
