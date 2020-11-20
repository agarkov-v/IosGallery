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
    func changePassword(passwordEntity: ChangePasswordEntity) -> Single<UserEntity>
}

class ApiUserGateway: ApiBaseGateway, UserGateway {
    
    func getAccount() -> Single<UserEntity> {
        return self.apiClient.execute(request: .getCurrentUser())
    }
    
    func updateUser(user: UpdateUserEntity) -> Single<UserEntity> {
        return self.apiClient.execute(request: .updateUser(user: user))
    }
    
    func changePassword(passwordEntity: ChangePasswordEntity) -> Single<UserEntity> {
        return self.apiClient.execute(request: .changePassword(password: passwordEntity))
    }
}
