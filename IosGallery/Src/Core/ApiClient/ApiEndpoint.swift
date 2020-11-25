//
//  ApiEndpoint.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import Foundation
import RxNetworkApiClient

extension ApiEndpoint {

//    static let base = ApiEndpoint("http://gallery.dev.webant.ru")
//
//    static var id = "5862"
//    static var randomId = "wgvccwmkf0g0s8g0ss8wckckkcos4sk0go40ogw4g004k0s4c"
//    static var clientSecret = "3msbuvhpc1wk8kgogk08wgw8oo4w0s8skkgkokow88sko4gks0"
//
//    static var clientId: String {
//        return id + "_" + randomId
//    }
    
    //------
    static var endpoint = "http://gallery.dev.webant.ru"
    
    static var id = "5793"
    static var randomId = "49b5fgezz0g00sg4wogosssgogwcckosc48sg8o84gkwk0088w"
    static var clientSecret = "1fgkaly9otwkw0gkw0gs040kcw0w8ogoc00ckc88g048oc8skg"
    
    static var clientId: String {
        return id + "_" + randomId
    }
}
