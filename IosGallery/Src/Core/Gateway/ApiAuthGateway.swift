//
//  ApiAuthGateway.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxSwift

protocol AuthGatewayProtocol {
    
    func auth(username: String, password: String) -> Single<TokenEntity>
    func refreshToken(refreshToken: String) -> Single<TokenEntity>
}

class ApiAuthGateway: ApiBaseGateway, AuthGatewayProtocol {
    
    func auth(username: String, password: String) -> Single<TokenEntity> {
        return self.apiClient.execute(request: .login(username: username, password: password))
    }
    
    func refreshToken(refreshToken: String) -> Single<TokenEntity> {
        return self.apiClient.execute(request: .refreshToken(refreshToken: refreshToken))
    }
}
