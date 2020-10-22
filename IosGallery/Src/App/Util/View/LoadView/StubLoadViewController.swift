//
//  StubLoadViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import UIKit

class StubLoadViewController: UIViewController {
    
    private var backgroundView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    private var messageLabel = UILabel()
    private var tap = UITapGestureRecognizer()
    private var backgroundColor: UIColor?
    
//    convenience init() {
//        fatalError("init() has not been implemented")
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(backgroundColor: UIColor = .clear) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        configureConstraints()
        activityIndicator.startAnimating()
        
    }
    
    private func prepareView() {
        self.view.backgroundColor = backgroundColor
        backgroundView.layer.cornerRadius = 8
        backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .white
        messageLabel.textColor = R.color.inactiveGray()
        messageLabel.text = "Loading...".localization()
    }
    
    private func configureConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundView.sizeToFit()
        self.view.addSubview(backgroundView)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activityIndicator)
        backgroundView.addSubview(messageLabel)
        
        backgroundView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 1/1).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 11).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 11).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: 5).isActive = true
        
        messageLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    }


}
