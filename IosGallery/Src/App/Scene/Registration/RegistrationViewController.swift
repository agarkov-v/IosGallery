//
//  RegistrationViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 17.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Cheeezcake Template Inc.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var fullNameTextField: UITextField!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordLabel: UILabel!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!

    internal var presenter: RegistrationPresenter!

    private var birthdayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        return datePicker
    }()
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }

    @IBAction private func onBackTouch(_ sender: UIBarButtonItem) {
        presenter.closeScreen()
    }

    @IBAction private func onSignUpTouch(_ sender: UIButton) {
        let emailText = emailTextField.text?.trimming()
        let phoneText = phoneTextField.text?.trimming()
        let fullNameText = fullNameTextField.text?.trimming()
        let userNameText = userNameTextField.text?.trimming()
        let birthdayText = birthdayTextField.text?.trimming()
        let passwordText = passwordTextField.text?.trimming()
        let confirmPasswordText = confirmPasswordTextField.text?.trimming()

        let textFields: [UITextField] = [emailTextField, phoneTextField, fullNameTextField, userNameTextField, birthdayTextField, passwordTextField, confirmPasswordTextField]

        guard let email = emailText, let phone = phoneText, let fullName = fullNameText, let userName = userNameText, let birthday = birthdayText, let password = passwordText, let confirmPassword = confirmPasswordText else {

            textFields.forEach { [weak self] in
                guard $0.text?.trimming() == nil else { return }
                self?.textFieldError($0)
            }
            showDialog(message: "Not all fields are filled in".localization())
            return
        }

        guard password == confirmPassword else {
            textFieldError(passwordTextField)
            textFieldError(confirmPasswordTextField)
            showDialog(message: "Passwords don't match".localization())
            return
        }

        presenter.onSignUp(email: email, phone: phone, fullName: fullName, userName: userName, birthday: birthday, password: password)
    }

    private func prepareView() {
        navigationBar.topItem?.title = "Registration".localization()
        titleView.isHidden = true
        titleLabel.text = "Registration".localization()
        emailLabel.text = "E-mail adress".localization()
        emailTextField.placeholder = "E-mail".localization()
        phoneLabel.text = "Phone number".localization()
        phoneTextField.placeholder = "Phone".localization()
        fullNameLabel.text = "Full name".localization()
        fullNameTextField.placeholder = "Full name".localization()
        userNameLabel.text = "User Name".localization()
        userNameTextField.placeholder = "User Name".localization()
        birthdayLabel.text = "Birthday".localization()
        birthdayTextField.placeholder = "Birthday".localization()
        birthdayTextField.inputView = birthdayDatePicker
        passwordLabel.text = "Password".localization()
        passwordTextField.placeholder = "Password".localization()
        passwordTextField.setRightViewIcon(icon: R.image.eyeIcon_second()!)
        confirmPasswordLabel.text = "Confirm password".localization()
        confirmPasswordTextField.placeholder = "Confirm password".localization()
        confirmPasswordTextField.setRightViewIcon(icon: R.image.eyeIcon_second()!)
        signUpButton.setTitle("Sign Up".localization(), for: .normal)
    }

    private func textFieldError(_ textField: UITextField) {
        textField.backgroundColor = .systemRed
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            textField.backgroundColor = R.color.whiteBlack()
        }
    }

    @objc private func dateChanged(datePicker: UIDatePicker) {
        birthdayTextField.text = DateFormatUtil.convertDateToStandartString(date: datePicker.date)
    }
}

// MARK: RegistrationView

extension RegistrationViewController: RegistrationView {

}
