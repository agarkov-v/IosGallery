//
//  AccountSettingsPresenter.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import Foundation
import RxSwift

protocol AccountSettingsView: BaseView {

    func updateView(user: UserEntity)
    func updateSegmentedControl(index: Int)
    func clearPasswordFields()
    func showPasswordError(with text: String)
    func hidePasswordError()
    func sctollToError()
}

protocol AccountSettingsPresenter {

    func viewDidLoad()
    func onBackBarButtonItem(username: String?, birthday: String?, email: String?, oldPassword: String, newPassword: String, confirmPassword: String)
    func onSaveTap(username: String?, birthday: String?, email: String?, oldPassword: String, newPassword: String, confirmPassword: String)
    func updateUser(username: String, birthday: String, email: String)
    func changePassword(oldPassword: String, newPassword: String, confirmPassword: String)
    func signOut()
    func changeTheme(index: Int)
}

class AccountSettingsPresenterImp: AccountSettingsPresenter {

    private weak var view: AccountSettingsView!
    private let router: AccountSettingsRouter
    private var disposeBag = DisposeBag()
    private let userGateway: UserGateway
    private let userManager: UserManager
    
    init(_ view: AccountSettingsView,
         _ router: AccountSettingsRouter,
         _ userGateway: UserGateway,
         _ userManager: UserManager) {
        self.view = view
        self.router = router
        self.userGateway = userGateway
        self.userManager = userManager
    }
    
    func onBackBarButtonItem(username: String?, birthday: String?, email: String?, oldPassword: String, newPassword: String, confirmPassword: String) {
        guard let user = userManager.user else {
            view.showDialog(message: "The data about user is missing. Log in again.".localization()) { [weak self] _ in
                self?.signOut()
            }
            return
        }
        guard let oldBirthdayDate = DateFormatUtil.convertStringToDate(stringDate: user.birthday, isSmpleFormat: false), let username = username, let birthday = birthday, let email = email else {
            view.showDialog(message: "Ошибка обработки даты", action: { [weak self] _ in
                self?.router.pop()
            })
            return
        }
        let newBirthdayDate = DateFormatUtil.convertStringToDate(stringDate: birthday)
        if oldPassword != "" || newPassword != "" || confirmPassword != "" || user.username != username || oldBirthdayDate != newBirthdayDate || user.email != email {
            view.showChoiceDialog(message: "You have unsaved changes. Do you still want to leave?".localization(), positiveMessage: "Да", negativeMessage: "Нет") { [weak self] isPositive in
                guard isPositive else { return }
                self?.router.pop()
            }
        } else {
            router.pop()
        }
    }

    func viewDidLoad() {
        getUser()
        view.updateSegmentedControl(index: Theme.current.rawValue)
    }

    func signOut() {
        AppDelegate.shared.doLogOut()
    }

    func onSaveTap(username: String?, birthday: String?, email: String?, oldPassword: String, newPassword: String, confirmPassword: String) {
        guard let username = username, let birthday = birthday, let email = email else { return }
        updateUser(username: username, birthday: birthday, email: email)

        changePassword(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
    }

    func updateUser(username: String, birthday: String, email: String) {
        guard let user = userManager.user else {
            view.showDialog(message: "The data about user is missing. Log in again.".localization()) { [weak self] _ in
                self?.signOut()
            }
            return
        }

        guard let oldBirthdayDate = DateFormatUtil.convertStringToDate(stringDate: user.birthday, isSmpleFormat: false) else {
            view.showDialog(message: "Ошибка обработки даты", action: nil)
            return
        }
        let newBirthdayDate = DateFormatUtil.convertStringToDate(stringDate: birthday)

        guard user.username != username || oldBirthdayDate != newBirthdayDate || user.email != email else { return }

        let newUser = UpdateUserEntity(id: user.id, email: email, username: username, birthday: birthday)

        userGateway.updateUser(user: newUser)
            .observeOn(MainScheduler.instance)
            .do(onSubscribed: { [weak self] in
                self?.view.showActivityIndicator()
            }, onDispose: { [weak self] in
                self?.view.hideActivityIndicator()
            })
            .subscribe(onSuccess: { [weak self] user in
                guard let self = self else { return }
                self.userManager.user = user
                self.view.updateView(user: user)
            }, onError: { [weak self] error in
                debugPrint("updateUser error: \(error) || \(error.localizedDescription)")
                self?.view.showDialog(message: error.localizedDescription, action: nil)
            })
            .disposed(by: disposeBag)
    }

    func changePassword(oldPassword: String, newPassword: String, confirmPassword: String) {
        guard let user = userManager.user else {
            view.showDialog(message: "The data about user is missing. Log in again.".localization()) { [weak self] _ in
                self?.signOut()
            }
            return
        }
        view.hidePasswordError()

        if oldPassword == "", newPassword == "", confirmPassword == "" { return }

        if oldPassword == "" || newPassword == "" || confirmPassword == "" {
            view.showPasswordError(with: "Not all fields are filled in".localization())
            view.sctollToError()
            return
        }
        guard newPassword == confirmPassword else {
            view.showPasswordError(with: "Passwords don't match".localization())
            view.sctollToError()
            return
        }
        guard oldPassword != newPassword else {
            view.showPasswordError(with: "The new password must be different from the old one".localization())
            view.sctollToError()
            return
        }
        let passwordEntity = ChangePasswordEntity(id: user.id, oldPassword: oldPassword, newPassword: newPassword)
        userGateway.changePassword(passwordEntity: passwordEntity)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                guard let self = self else { return }
                self.view.showDialog(message: "Password successfully updated".localization(), action: nil)
                self.view.clearPasswordFields()
            }, onError: { [weak self] error in
                debugPrint("changePassword error: \(error) || \(error.localizedDescription)")
                self?.view.showDialog(message: error.localizedDescription, action: nil)
                self?.view.sctollToError()
            })
            .disposed(by: disposeBag)
    }

    func changeTheme(index: Int) {
        guard let theme = Theme(rawValue: index) else { return }
        theme.setActive()
    }

    private func getUser() {
        if let user = userManager.user {
            view.updateView(user: user)
        }
    }
}

