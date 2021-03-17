//
//  ApiUserGateway.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxSwift

protocol UserGateway {
    
    func getAccount() -> Single<UserEntity>
    func updateUser(user: UpdateUserEntity) -> Single<UserEntity>
    func getUser(id: String) -> Single<UserEntity>
    func changePassword(passwordEntity: ChangePasswordEntity) -> Single<UserEntity>
}

class ApiUserGateway: ApiBaseGateway, UserGateway {
    
    func getAccount() -> Single<UserEntity> {
        return apiClient.execute(request: .getCurrentUser())
    }
    
    func updateUser(user: UpdateUserEntity) -> Single<UserEntity> {
        return apiClient.execute(request: .updateUser(user: user))
    }

    func getUser(id: String) -> Single<UserEntity> {
        return apiClient.execute(request: .getUser(id: id))
    }
    
    func changePassword(passwordEntity: ChangePasswordEntity) -> Single<UserEntity> {
        return apiClient.execute(request: .changePassword(password: passwordEntity))
    }
}
