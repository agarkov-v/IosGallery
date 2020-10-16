//
//  AccountCell.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        accountView.layer.cornerRadius = 4
        accountImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
