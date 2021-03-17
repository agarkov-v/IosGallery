//
//  AuthUseCase.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxSwift

protocol AuthUseCase {
    
    func login(username: String, password: String) -> Completable
    func refreshToken() -> Completable
}

class AuthUseCaseImp: AuthUseCase {

    private let authGateway: AuthGateway
    private let userGateway: UserGateway
    private let userManager: UserManager
    
    init(authGateway: AuthGateway,
         userGateway: UserGateway,
         userManager: UserManager) {
        self.authGateway = authGateway
        self.userGateway = userGateway
        self.userManager = userManager
    }
    
    func login(username: String, password: String) -> Completable {
        return authGateway.auth(username: username, password: password)
            .asCompletable()
            .andThen(userGateway.getAccount())
            .asCompletable()
    }
    
    func refreshToken() -> Completable {
        guard let refreshToken = self.userManager.token?.refreshToken else {
            return .error(AppError.tokenRefreshingError)
        }
        return authGateway.refreshToken(refreshToken: refreshToken)
            .asCompletable()
    }
}
