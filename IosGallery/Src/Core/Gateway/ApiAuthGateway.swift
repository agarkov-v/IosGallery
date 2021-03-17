//
//  ApiAuthGateway.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxSwift

protocol AuthGateway {
    
    func auth(username: String, password: String) -> Single<TokenEntity>
    func refreshToken(refreshToken: String) -> Single<TokenEntity>
}

class ApiAuthGateway: ApiBaseGateway, AuthGateway {
    
    func auth(username: String, password: String) -> Single<TokenEntity> {
        return apiClient.execute(request: .login(username: username, password: password))
    }
    
    func refreshToken(refreshToken: String) -> Single<TokenEntity> {
        return apiClient.execute(request: .refreshToken(refreshToken: refreshToken))
    }
}
