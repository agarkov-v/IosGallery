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
//    func showAlert(message: String, completion: (() -> Void)?)
//    func clearPasswordFields()
}

protocol AccountSettingsPresenter {

    func onBackBarButtonItem()
// 
    func viewDidLoad()
//    func updateUser(username: String, birthday: Date, email: String)
//    func changePassword(oldPassword: String, newPassword: String)
    func signOut()
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
    
    func onBackBarButtonItem() {
        router.pop()
    }

    func viewDidLoad() {
        getUser()
    }

    private func getUser() {
        if let user = userManager.user {
            self.view.updateView(user: user)
        }
    }

    func signOut() {
//        userManager.token = nil
//        userManager.user = nil
//        LoginConfigurator.open()
        AppDelegate.shared.doLogOut()
    }

//    func updateUser(username: String, birthday: Date, email: String) {
//        guard let user = userManager.user else {
//            self.view.showAlert(message: "Информация пользователя отсутсвует") {
//                LoginConfigurator.open()
//            }
//            return
//        }
//
//        //print(user.birthday, birthday, user.birthday == birthday)
//        //TODO
//
//        guard let date = self.isoDateFormatter.date(from: user.birthday) else {
//            self.view.showAlert(message: "Ошибка обработки даты",
//                                completion: nil)
//            return
//        }
//
//        if user.username == username, date == birthday, user.email == email {
//            return
//        }
//
//        let newUser = UpdateUserEntity(id: user.id, email: email, username: username, birthday: self.isoDateFormatter.string(from: birthday))
//
//        EZLoadingActivity.show("Wait please...", disableUI: true)
//
//        self.gateway.updateUser(user: newUser)
//            .subscribe(onSuccess: { (user) in
//                self.manager.user = user
//                DispatchQueue.main.async {
//                    EZLoadingActivity.hide()
//                    self.view.updateView(user: user)
//                }
//            }, onError: { (error) in
//                DispatchQueue.main.async {
//                    EZLoadingActivity.hide()
//                    self.view.showAlert(message: error.localizedDescription,
//                                        completion: nil)
//                }
//            })
//            .disposed(by: self.bag)
//    }
//
//    func changePassword(oldPassword: String, newPassword: String) {
//        guard let user = self.manager.user else {
//            self.view.showAlert(message: "Информация пользователя отсутсвует") {
//                LoginConfigurator.open()
//            }
//            return
//        }
//        let passwordEntity = ChangePasswordEntity(id: user.id, oldPassword: oldPassword, newPassword: newPassword)
//        self.gateway.changePassword(passwordEntity: passwordEntity)
//            .subscribe(onSuccess: { (user) in
//                DispatchQueue.main.async {
//                    self.view.showAlert(message: "Пароль обновлен",
//                                        completion: nil)
//                    self.view.clearPasswordFields()
//                }
//            }, onError: { (error) in
//                print(error)
//                DispatchQueue.main.async {
//                    self.view.showAlert(message: error.localizedDescription,
//                                        completion: nil)
//                }
//            })
//            .disposed(by: self.bag)
//    }
}

