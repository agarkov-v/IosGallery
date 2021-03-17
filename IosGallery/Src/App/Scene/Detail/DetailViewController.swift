//
//  DetailViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var presenter: DetailPresenter!

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavigationBar("Image Detail")
        prepateView()
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTitleNavigationBar("")
    }
    
    private func prepateView() {
        descriptionTextView.textContainer.lineFragmentPadding = 0
    }
    
}

// MARK: DetailView
extension DetailViewController: DetailView {

    func setupView(galleryItem: GalleryEntity) {
        if galleryItem.image.name == "testPlaceholderImage" {
            detailImageView.image = UIImage(named: galleryItem.image.name)
        } else {
            let url = URL(string: "http://gallery.dev.webant.ru/media/" + galleryItem.image.name)
            detailImageView.kf.setImage(with: url)
        }
        nameLabel.text = galleryItem.name
        descriptionTextView.text = galleryItem.description
        var dateCreate = galleryItem.dateCreate
        if galleryItem.dateCreate.contains("-0001") {
            dateCreate = galleryItem.dateCreate.replacingOccurrences(of: "-0001", with: "2020", options: .literal, range: nil)
        }
        dateLabel.text = DateFormatUtil.standartDateFormat(dateString: dateCreate)
    }

    func updateUser(user: String) {
        userNameLabel.text = user
    }
}
