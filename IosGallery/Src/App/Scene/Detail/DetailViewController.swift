//
//  DetailViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    var testImage: UIImage!
    var testLabel: String!
    var testUserName: String!
    var testDate: String!
    var testDescr: String!
    
    var presenter: DetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = testImage
        nameLabel.text = testLabel
        userNameLabel.text = testUserName
        dateLabel.text = testDate
        descriptionTextView.text = testDescr
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavigationBar("Image Detail")
        prepateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func prepateView() {
        descriptionTextView.textContainer.lineFragmentPadding = 0
    }
    
}

extension DetailViewController: DetailView {
    
}
