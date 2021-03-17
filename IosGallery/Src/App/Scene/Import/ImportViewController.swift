//
//  ImportViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class ImportViewController: UIViewController {

    @IBOutlet private weak var importScrollView: UIScrollView!
    @IBOutlet private weak var importImageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var presenter: ImportPresenter!
    //    private let pickerController = UIImagePickerController()

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        ImportConfigurator().configure(view: self)
        configureBarButtonItem()
        configureImageGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavigationBar(entity: .uploadImage)
        prepateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        descriptionTextView.layer.borderColor = R.color.gray()!.cgColor
    }
    
    private func prepateView() {
        importImageView.image = R.image.photoPlaceholder()
        nameTextField.placeholder = "Name".localization()
        
        nameTextField.layer.cornerRadius = 4
        descriptionTextView.layer.cornerRadius = 4
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = R.color.gray()!.cgColor
        descriptionTextView.text = "Description".localization()
        descriptionTextView.textColor = R.color.placeholderGray()
        descriptionTextView.delegate = self
    }
    
    private func configureBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(title: "Add".localization(), style: .plain, target: self, action: #selector(onRightBarButtonItem))
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
                          NSAttributedString.Key.foregroundColor: R.color.pink()!]
        rightBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func configureImageGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImagePickerControllerActionSheet))
        importImageView.addGestureRecognizer(tapGestureRecognizer)
        importImageView.isUserInteractionEnabled = true
    }

    @objc private func onRightBarButtonItem() {
        print("onRightBarButtonItem click")
        guard let image = importImageView.image, image != R.image.photoPlaceholder() else {
            self.showAlert(title: "The image is not selected".localization())
            return
        }
        guard let name = nameTextField.text?.trimming(), !name.isEmpty else {
            self.showAlert(title: "Enter image name".localization())
            return
        }
        guard let description = descriptionTextView.text?.trimming(), !description.isEmpty, description != "Description", description != "Описание" else {
            self.showAlert(title: "Enter image description".localization())
            return
        }
        presenter.importImage(image: image, name: name, description: description)
    }
    
    @objc private func showImagePickerControllerActionSheet() {
        self.showActionSheetAlert(title: "",
                                  message: "Choose image from:".localization(),
                                  firstActionTitle: "Photo library".localization(),
                                  secondActionTitle: "Camera".localization(),
                                  firstCompletion: { [weak self] in self?.showImagePickerController(sourceType: .photoLibrary) },
                                  secondCompletion: { [weak self] in self?.showImagePickerController(sourceType: .camera) })
    }
}

// MARK: UITextViewDelegate

extension ImportViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Description" || textView.text == "Описание" {
            textView.text = ""
            textView.textColor = R.color.blackWhite()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description"
            textView.textColor = R.color.placeholderGray()
        }
    }
}

// MARK: ImportView

extension ImportViewController: ImportView {

    func cleanView() {
        importImageView.image = nil
        nameTextField.text = nil
        descriptionTextView.text = nil
    }
}

// MARK: UIImagePickerControllerDelegate

extension ImportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            importImageView.image = editedImage
        } else {
            self.showAlert(title: "Error with image picker".localization())
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ImportViewController: ScrollableToTop {
    func scrollToTop() {
        self.importScrollView.scrollToTop(true)
    }
}
