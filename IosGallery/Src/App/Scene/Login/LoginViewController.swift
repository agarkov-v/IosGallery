//
//  LoginViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var deviceOreintation: UIDeviceOrientation {
        get {
            return UIDevice.current.orientation
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func prepareView() {
        loginTextField.placeholder = "login"
        passwordTextField.placeholder = "password"
        signInButton.titleLabel?.text = "Sign in"
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
