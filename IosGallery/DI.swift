//
//  DI.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import DITranquillity
import RxNetworkApiClient

class DI {
    
    private static var container = DIContainer()
    
    static func initDependencies() {
        
        //MARK: - Managers
        self.container.register(UserDefaultsManagerImp.init)
            .as(UserDefaultsManager.self)
//            .lifetime(.objectGraph)
        
        self.container.register {
            UserManager(userDefaultsManager: $0)
        }
        .as(UserManager.self)
//        .lifetime(.single)
        
        //MARK: - Interseptor
        self.container.register(AuthInterceptor.init)
            .as(AuthInterceptor.self)
            .lifetime(.single)
        
        // MARK: - Handlers
        self.container.register(AuthResponseHandler.init)
            .as(AuthResponseHandler.self)
            .lifetime(.single)
        
        // MARK: - ApiClient
        self.container.register { () -> ApiClientImp in
            let client = ApiClientImp.defaultInstance(host: ApiEndpoint.base.host)
            client.interceptors.removeAll()
            return client
        }
            .as(ApiClient.self)
            .injection(cycle: true) {
                $0.interceptors.insert($1 as AuthInterceptor, at: 0)
            }
            .injection(cycle: true) {
                $0.responseHandlersQueue.insert($1 as AuthResponseHandler, at: 0)
            }
            .lifetime(.single)
        
        // MARK: - Gateways
        self.container.register(ApiAuthGateway.init)
            .as(AuthGateway.self)
            .lifetime(.single)

        self.container.register(ApiUserGateway.init)
            .as(UserGateway.self)
            .lifetime(.single)

        self.container.register(ApiGalleryGateway.init)
            .as(GalleryGateway.self)
            .lifetime(.single)

        self.container.register(ApiImageGateway.init)
            .as(ImageGateway.self)
            .lifetime(.single)
        
        // MARK: - UseCases
        self.container.register(AuthUseCaseImp.init)
            .as(AuthUseCase.self)
        
        self.container.register(UserUseCaseImp.init)
            .as(UserUseCase.self)
        
        self.container.register(GalleryUseCaseImp.init)
            .as(GalleryUseCase.self)
        
        self.container.register(AccountUseCaseImp.init)
            .as(AccountUseCase.self)
    }
    
    static func resolve<T>() -> T {
        return self.container.resolve()
    }
}
