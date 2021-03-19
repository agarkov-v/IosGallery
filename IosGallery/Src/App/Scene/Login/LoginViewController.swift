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
            #if DEBUG
            loginTextField.text = "testGalleryUser"
            #endif
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            #if DEBUG
            passwordTextField.text = "test123"
            #endif
        }
    }
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet weak var testSignInView: UIView!
    @IBOutlet weak var testSignInLabel: UILabel!
    @IBOutlet weak var testSignInButton: UIButton!
    
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

        #if DEBUG
        testSignInView.isHidden = false
        #endif
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

    @IBAction private func onSignInButton(_ sender: UIButton) {
        guard let username = loginTextField.text?.trimmingCharacters(in: .whitespaces),
              !username.isEmpty,
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces),
              !password.isEmpty else {
            errorView.isHidden = false
            errorLabel.text = "Fields must not be empty".localization()
            return
        }
        errorView.isHidden = true
        presenter.signIn(username, password)
    }

    @IBAction private func onSignUpButton(_ sender: UIButton) {
        presenter.onSignUpButton()

    }

    @IBAction private func onTestSignInButton(_ sender: UIButton) {
        presenter.onTestSignInButton()
    }
    
    @objc private func onViewTap() {
        view.endEditing(true)
    }
    
    private func prepareView() {
        let cornerRadius: CGFloat = 4

        welcomeLabel.text = "Welcome!".localization()
        loginTextField.placeholder = "login".localization()
        passwordTextField.placeholder = "password".localization()
        signInButton.setTitle("Sign In".localization(), for: .normal)
        signUpButton.setTitle("Sign Up".localization(), for: .normal)
        loginTextField.layer.cornerRadius = cornerRadius
        passwordTextField.layer.cornerRadius = cornerRadius
        signInButton.layer.cornerRadius = cornerRadius
        passwordTextField.setRightViewIcon(icon: R.image.eyeIcon()!)

        testSignInButton.layer.cornerRadius = cornerRadius
        testSignInButton.setTitle("Sign in as Test user".localization(), for: .normal)
        testSignInLabel.text = "Use it in case the Api is not available".localization()
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
        testSignInView.isHidden = true
    }
}
