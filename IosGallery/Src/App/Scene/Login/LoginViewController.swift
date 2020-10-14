//
//  LoginViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var deviceOreintation: UIDeviceOrientation {
        get {
            return UIDevice.current.orientation
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewGesture = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        view.addGestureRecognizer(viewGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadInLanscape()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateViewVisability()
    }

    @IBAction func onSignInButton(_ sender: UIButton) {
        
    }
    
    @objc func onViewTap() {
        self.view.endEditing(true)
    }
    
    func prepareView() {
        welcomeLabel.text = "Welcome!".localization()
        loginTextField.placeholder = "login".localization()
        passwordTextField.placeholder = "password".localization()
        signInButton.titleLabel?.text = "Sign In".localization()
        loginTextField.layer.cornerRadius = 4
        passwordTextField.layer.cornerRadius = 4
        signInButton.layer.cornerRadius = 4
        passwordTextField.setRightViewIcon(icon: R.image.eye_icon()!)
    }
    
    func loadInLanscape() {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            print("loadInLandscape isLandscape")
            logoView.isHidden = true
        }
    }
    
    func updateViewVisability() {
        if deviceOreintation.isLandscape {
            logoView.isHidden = true
        } else if deviceOreintation.isPortrait {
            logoView.isHidden = false
        }
    }
}
