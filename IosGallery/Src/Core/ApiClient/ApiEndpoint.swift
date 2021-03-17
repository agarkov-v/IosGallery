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
    static var endpoint = "http://gallery.dev.webant.ru"

    static var id = "5916"
    static var randomId = "1emet312oy2scosc040gc40s40gk8cwwcw4g4kwc0w48s48cs8"
    static var clientSecret = "6bexn2yl778ccsg0ko48swkw80s880cw48ogw4cgksck40o8ks"

    static var clientId: String {
        return id + "_" + randomId
    }
}
