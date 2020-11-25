//
//  AuthInterceptor.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxNetworkApiClient

class AuthInterceptor: Interceptor {
    
    private let manager: UserManager
    
    init(manager: UserManager) {
        self.manager = manager
    }
    
    func prepare<T>(request: ApiRequest<T>) where T: Decodable, T: Encodable {
        if request.path?.contains("oauth") != true {
            let authHeaderKey = "Authorization"
            let index = request.headers?.firstIndex(where: { $0.key == authHeaderKey })
            if let auth = manager.token {
                let authHeader = Header(authHeaderKey, "Bearer \(auth.accessToken)")
                if index == nil {
                    if request.headers == nil {
                        request.headers = [authHeader]
                    } else {
                        request.headers!.append(authHeader)
                    }
                } else {
                    request.headers![index!] = authHeader
                }
            }
        }
    }
    
    func handle<T>(request: ApiRequest<T>, response: NetworkResponse) where T: Decodable, T: Encodable {
        //not implemented
    }
}
