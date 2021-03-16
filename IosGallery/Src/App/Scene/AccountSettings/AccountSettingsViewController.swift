//
//  AccountSettingsViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class AccountSettingsViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var modeView: UIView!
    @IBOutlet private weak var colorModeLabel: UILabel!
    @IBOutlet private weak var colorModeSegmentControl: UISegmentedControl!
    @IBOutlet private weak var iconModeLabel: UILabel!
    @IBOutlet private weak var iconModeSwitch: UISwitch!
    @IBOutlet private weak var personalDataLabel: UILabel!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var oldPasswordTextField: UITextField!
    @IBOutlet private weak var newPasswordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var signOutButton: UIButton!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!

    var presenter: AccountSettingsPresenter!

    private let appIconService = AppIconService()
    private let userDefaults = UserDefaults.standard

    private var birthdayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
//        if #available(iOS 13.0, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
        return datePicker
    }()

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItem()
        presenter.viewDidLoad()
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
        setupTitleNavigationBar("Settings")
        setupActionLeftButton(action: #selector(onBackButtonTap))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    @IBAction func onChangeTheme(_ sender: UISegmentedControl) {
        presenter.changeTheme(index: sender.selectedSegmentIndex)
    }
    
    @IBAction private func onSignOut(_ sender: UIButton) {
        showChoiceDialog(message: "Вы точно хотите выйти?".localization(), positiveMessage: "Yes".localization(), negativeMessage: "No".localization(), onChoice: { [weak self] isPositive in
            guard isPositive else { return }
                self?.presenter.signOut()
        })
    }
    
    @IBAction private func onIconModeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            appIconService.changeAppIcon(to: .iconDark)
            userDefaults.set(true, forKey: "isDarkModeIcon")
        } else {
            appIconService.changeAppIcon(to: .iconPrimary)
            userDefaults.set(false, forKey: "isDarkModeIcon")
        }
        
//        sender.isOn ? appIconService.changeAppIcon(to: .iconDark) : appIconService.changeAppIcon(to: .iconPrimary)
    }
    
    private func prepateView() {
        colorModeLabel.text = "Color mode:".localization()
        iconModeLabel.text = "Dark app icon:".localization()
        colorModeSegmentControl.setTitle("System".localization(), forSegmentAt: 0)
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
        birthdayTextField.inputView = birthdayDatePicker
    }
    
    private func configureBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(title: "Save".localization(), style: .plain, target: self, action: #selector(onRightBarButtonItem))
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
                          NSAttributedString.Key.foregroundColor: R.color.pink()!]
        rightBarButtonItem.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc private func onBackButtonTap() {
        let username = userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let birthday = birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let oldPassword = oldPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let newPassword = newPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let confirmPassword = confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        presenter.onBackBarButtonItem(username: username, birthday: birthday, email: email, oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
    }

    @objc private func dateChanged(datePicker: UIDatePicker) {
        birthdayTextField.text = DateFormatUtil.convertDateToStandartString(date: datePicker.date)
    }
    
    @objc private func onRightBarButtonItem() {
        print("onRightBarButtonItem click")
        let username = userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let birthday = birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let oldPassword = oldPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let newPassword = newPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let confirmPassword = confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        presenter.onSaveTap(username: username, birthday: birthday, email: email, oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
    }
}

// MARK: AccountSettingsView

extension AccountSettingsViewController: AccountSettingsView {

    func updateView(user: UserEntity) {
        userNameTextField.text = user.username
        birthdayTextField.text = DateFormatUtil.standartDateFormat(dateString: user.birthday)
        emailTextField.text = user.email

        if let date = DateFormatUtil.convertStringToDate(stringDate: user.birthday, isSmpleFormat: false) {
            birthdayDatePicker.setDate(date, animated: false)
            birthdayTextField.text = DateFormatUtil.convertDateToStandartString(date: date)
        }
    }

    func updateSegmentedControl(index: Int) {
        colorModeSegmentControl.selectedSegmentIndex = index
    }

    func clearPasswordFields() {
        oldPasswordTextField.text = nil
        newPasswordTextField.text = nil
        confirmPasswordTextField.text = nil
    }

    func showPasswordError(with text: String) {
        errorView.isHidden = false
        errorLabel.text = text
        oldPasswordTextField.backgroundColor = .systemRed
        newPasswordTextField.backgroundColor = .systemRed
        confirmPasswordTextField.backgroundColor = .systemRed
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.oldPasswordTextField.backgroundColor = R.color.whiteBlack()
            self.newPasswordTextField.backgroundColor = R.color.whiteBlack()
            self.confirmPasswordTextField.backgroundColor = R.color.whiteBlack()
        }
    }

    func hidePasswordError() {
        errorView.isHidden = true
    }

    func sctollToError() {
        if scrollView.contentSize.height < scrollView.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
}
