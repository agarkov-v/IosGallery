//
//  ImportViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class ImportViewController: UIViewController {

    @IBOutlet weak var importImageView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var presenter: ImportPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func prepateView() {
        nameTextField.placeholder = "Name".localization()
        
        nameTextField.layer.cornerRadius = 4
        descriptionTextView.layer.cornerRadius = 4
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = R.color.gray()!.cgColor
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = .lightGray
        descriptionTextView.delegate = self
    }
    
    func configureBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(title: "Add".localization(), style: .plain, target: self, action: #selector(onRightBarButtonItem))
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold),
                          NSAttributedString.Key.foregroundColor : R.color.pink()!]
        rightBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func onRightBarButtonItem() {
        print("onRightBarButtonItem click")
    }

}

extension ImportViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Description" {
            textView.text = ""
            textView.textColor = .black
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
            textView.textColor = .lightGray
        }
    }
}

extension ImportViewController: ImportView {
    
}
