//
//  AuthResponseHandler.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxNetworkApiClient
import RxSwift

class AuthResponseHandler: ResponseHandler {
    
    private let useCase: AuthUseCase
    private let manager: UserManager
    private let apiClient: ApiClient
    
    private let bag = DisposeBag()
    
    private var refreshingCount = 0
    
    init(useCase: AuthUseCase,
         manager: UserManager,
         apiClient: ApiClient)
    {
        self.useCase = useCase
        self.manager = manager
        self.apiClient = apiClient
    }
    
    func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                            request: ApiRequest<T>,
                            response: NetworkResponse) -> Bool {
        guard let data = response.data else {
            return false
        }
        
        if let errorEntity = try? JSONDecoder().decode(AuthResponseEntity.self, from: data) {
            let error = errorEntity.errorDescription.lowercased()
            switch error {
            case let er where er.contains("invalid username and password combination"):
                observer(.error(AppError.loginPasswordError))
                return true
            case let er where er.contains("the access token provided has expired."):
                self.refreshToken(observer: observer)
                observer(.error(AppError.tokenExpiredError))
                return true
            default:
                break
            }
        }
        
        if let token = try? JSONDecoder().decode(TokenEntity.self, from: data) {
            self.manager.token = token
        }
        
        if let user = try? JSONDecoder().decode(UserEntity.self, from: data) {
            self.manager.user = user
        }
        
        return false
    }
    
    func refreshToken<T: Codable>(observer: @escaping SingleObserver<T>) {
        if self.refreshingCount > 3 {
            observer(.error(AppError.tokenRefreshingError))
            return
        }
        self.refreshingCount += 1
        useCase.refreshToken()
            .catchError({ (error) -> Completable in
                if error is AppError {
                    return .error(AppError.tokenRefreshingError)
                } else {
                    return self.useCase.refreshToken()
                }
            })
            .subscribe(onCompleted: {
            }, onError: { observer(.error($0)) })
            .disposed(by: self.bag)
    }
}

