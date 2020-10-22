//
//  AuthUseCase.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxSwift

protocol AuthUseCaseProtocol {
    
    func login(username: String, password: String) -> Completable
    func refreshToken() -> Completable
}

class AuthUseCase: AuthUseCaseProtocol {

    private let authGateway: AuthGatewayProtocol
    private let userGateway: UserGatewayProtocol
    private let manager: UserManager
    
    init(authGateway: AuthGatewayProtocol,
         userGateway: UserGatewayProtocol,
         manager: UserManager) {
        self.authGateway = authGateway
        self.userGateway = userGateway
        self.manager = manager
    }
    
    func login(username: String, password: String) -> Completable {
        return authGateway.auth(username: username, password: password)
            .asCompletable()
            .andThen(userGateway.getAccount())
            .asCompletable()
    }
    
    func refreshToken() -> Completable {
        guard let refreshToken = self.manager.token?.refreshToken else {
            return .error(AppError.tokenRefreshingError)
        }
        return authGateway.refreshToken(refreshToken: refreshToken)
            .asCompletable()
    }
}
