//
//  DetailViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var presenter: DetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavigationBar("Image Detail")
        prepateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTitleNavigationBar("")
    }
    
    func prepateView() {
        descriptionTextView.textContainer.lineFragmentPadding = 0
    }
    
}

extension DetailViewController: DetailView {

    func setipView(galleryItem: GalleryEntity) {
        let url = URL(string: "http://gallery.dev.webant.ru/media/" + galleryItem.image.name)
        detailImageView.kf.setImage(with: url)
        nameLabel.text = galleryItem.name
        userNameLabel.text = galleryItem.user ?? "User unknown"
        descriptionTextView.text = galleryItem.description
        dateLabel.text = DateFormatUtil.standartDateFormat(dateString: galleryItem.dateCreate)
//        "-yyyy-MM-dd'T'HH:mm:ssZ"
    }
}
