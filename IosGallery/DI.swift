//
//  DI.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import DITranquillity
import RxNetworkApiClient

class DI {
    
    private static let shared = DI()
    fileprivate(set) static var container = DIContainer()
    
    static func initDependencies() {
        
    }
    
    static func resolve<T>() -> T {
        return self.container.resolve()
    }
}
