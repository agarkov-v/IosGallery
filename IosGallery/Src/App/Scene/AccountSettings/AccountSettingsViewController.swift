//
//  AccountSettingsViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class AccountSettingsViewController: UIViewController {

    @IBOutlet weak var modeView: UIView!
    @IBOutlet weak var colorModeLabel: UILabel!
    @IBOutlet weak var colorModeSegmentControl: UISegmentedControl!
    @IBOutlet weak var iconModeLabel: UILabel!
    @IBOutlet weak var iconModeSwitch: UISwitch!
    @IBOutlet weak var personalDataLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let appIconService = AppIconService()
    private let userDefaults = UserDefaults.standard
    var presenter: AccountSettingsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItem()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 13.0, *) {
            modeView.isHidden = false
            userDefaults.bool(forKey: "isDarkModeIcon") ? iconModeSwitch.setOn(true, animated: false) : iconModeSwitch.setOn(false, animated: false)
        } else {
            modeView.isHidden = true
        }
        prepateView()
        addBackBarButtonOnNavigationBar(action: #selector(onBackButtonTap), "Settings")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if isDarkModeIcon
//
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func onSignOut(_ sender: UIButton) {
//        if self.presenter.hasChanged  {
//            self.onTryToClose()
//        } else {
//            self.presenter.close()
//        }
    }
    
    @IBAction func onIconModeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            appIconService.changeAppIcon(to: .iconDark)
            userDefaults.set(true, forKey: "isDarkModeIcon")
        } else {
            appIconService.changeAppIcon(to: .iconPrimary)
            userDefaults.set(false, forKey: "isDarkModeIcon")
        }
        
//        sender.isOn ? appIconService.changeAppIcon(to: .iconDark) : appIconService.changeAppIcon(to: .iconPrimary)
    }
    
    @objc func onBackButtonTap() {
        presenter.onBackBarButtonItem()
    }
    
    func prepateView() {
        colorModeLabel.text = "Color mode:".localization()
        colorModeSegmentControl.setTitle("System".localization(), forSegmentAt: 0)
        iconModeLabel.text = "Dark app icon:".localization()
        colorModeSegmentControl.setTitle("Light".localization(), forSegmentAt: 1)
        colorModeSegmentControl.setTitle("Dark".localization(), forSegmentAt: 2)
        personalDataLabel.text = "Personal data".localization()
        userNameTextField.layer.cornerRadius = 4
        userNameTextField.placeholder = "User name".localization()
        birthdayTextField.layer.cornerRadius = 4
        birthdayTextField.placeholder = "Date of birth".localization()
        emailLabel.text = "E-mail adress".localization()
        emailTextField.layer.cornerRadius = 4
        emailTextField.placeholder = "E-mail"
        passwordLabel.text = "Password".localization()
        oldPasswordTextField.layer.cornerRadius = 4
        oldPasswordTextField.placeholder = "Old password".localization()
        oldPasswordTextField.setRightViewIcon(icon: R.image.eyeIcon_second()!)
        newPasswordTextField.layer.cornerRadius = 4
        newPasswordTextField.placeholder = "New password".localization()
        newPasswordTextField.setRightViewIcon(icon: R.image.eyeIcon_second()!)
        confirmPasswordTextField.layer.cornerRadius = 4
        confirmPasswordTextField.placeholder = "Confirm password".localization()
        confirmPasswordTextField.setRightViewIcon(icon: R.image.eyeIcon_second()!)
        signOutButton.titleLabel?.text = "Sign Out".localization()
        signOutButton.layer.cornerRadius = 4
        
    }
    
    func configureBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(title: "Save".localization(), style: .plain, target: self, action: #selector(onRightBarButtonItem))
        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold),
                          NSAttributedString.Key.foregroundColor : R.color.pink()!]
        rightBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func onRightBarButtonItem() {
        print("onRightBarButtonItem click")
    }

}

extension AccountSettingsViewController: AccountSettingsView {
    
}
