//
//  LoginViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var logoView: UIView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField! {
        didSet {
            loginTextField.text = "daem0n61"
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.text = "QMqa8DAD"
        }
    }
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!

    var presenter: LoginPresenter!

    private var deviceOreintation: UIDeviceOrientation {
        UIDevice.current.orientation
    }

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        LoginConfigurator().configure(view: self)
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
        guard let username = loginTextField.text?.trimmingCharacters(in: .whitespaces),
              !username.isEmpty,
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces),
              !password.isEmpty else {
            errorView.isHidden = false
            errorLabel.text = "Fields must not be empty"
            return
        }
        errorView.isHidden = true
        presenter.signIn(username, password)
    }
    
    @objc private func onViewTap() {
        view.endEditing(true)
    }
    
    private func prepareView() {
        welcomeLabel.text = "Welcome!".localization()
        loginTextField.placeholder = "login".localization()
        passwordTextField.placeholder = "password".localization()
        signInButton.titleLabel?.text = "Sign In".localization()
        loginTextField.layer.cornerRadius = 4
        passwordTextField.layer.cornerRadius = 4
        signInButton.layer.cornerRadius = 4
        passwordTextField.setRightViewIcon(icon: R.image.eyeIcon()!)
    }
    
    private func loadInLanscape() {
        guard UIApplication.shared.statusBarOrientation.isLandscape else { return }
        print("loadInLandscape isLandscape")
        logoView.isHidden = true
    }
    
    private func updateViewVisability() {
        if deviceOreintation.isLandscape {
            logoView.isHidden = true
        } else if deviceOreintation.isPortrait {
            logoView.isHidden = false
        }
    }
}

// MARK: LoginView

extension LoginViewController: LoginView {
    
    func showErrorView(message: String) {
        errorView.isHidden = false
        errorLabel.text = message.localization()
    }
    
    func hideErrorView() {
        errorView.isHidden = true
    }
}
