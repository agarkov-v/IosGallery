//
//  Requests.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation
import RxNetworkApiClient

extension ApiRequest {
    
    static func login(username: String, password: String) -> ApiRequest {
        return request(path: "/oauth/v2/token",
                       method: .get,
                       query: ("client_id", ApiEndpoint.clientId),
                       ("grant_type", "password"),
                       ("username", username),
                       ("password", password),
                       ("client_secret", ApiEndpoint.clientSecret))
    }
    
    static func refreshToken(refreshToken: String) -> ApiRequest {
        return request(path: "/oauth/v2/token",
                       method: .get,
                       query: ("client_id", ApiEndpoint.clientId),
                       ("grant_type", "refresh_token"),
                       ("refresh_token", refreshToken),
                       ("client_secret", ApiEndpoint.clientSecret))
    }
    
    static func getCurrentUser() -> ApiRequest {
        return request(path: "/api/users/current",
                       method: .get)
    }
    
    static func getPhotos(page: Int, limit: Int, type: GalleryType, searchBy text: String? = nil) -> ApiRequest {
        var new: (String, String?)!
        var popular: (String, String?)!
        switch type {
        case .new:
            new = ("new", "true")
            popular = ("popular", "false")
        case .popular:
            new = ("new", "false")
            popular = ("popular", "true")
        }
        return request(path: "/api/photos",
                       method: .get,
                       query: ("page", String(page)),
                       ("limit", String(limit)),
                       new,
                       popular,
                       ("name", text))
    }
    
    static func getPhotos(page: Int, limit: Int, userId: Int) -> ApiRequest {
        return request(path: "/api/photos",
                       method: .get,
                       query: ("page", String(page)),
                       ("limit", String(limit)),
                       ("user.id", String(userId)))
    }
    
    static func uploadFile(file: UploadFile) -> ApiRequest {
        return request(path: "/api/media_objects",
                       method: .post,
                       files: [file])
    }
    
    static func uploadGallery(gallery: UploadGalleryEntity) -> ApiRequest {
        return request(path: "/api/photos",
                       method: .post,
                       headers: [.contentJson],
                       body: gallery)
    }
    
    static func updateUser(user: UpdateUserEntity) -> ApiRequest {
        return request(path: "/api/users/\(user.id)",
            method: .put,
            headers: [.contentJson],
            body: user)
    }
    
    static func changePassword(password: ChangePasswordEntity) -> ApiRequest {
        return request(path: "/api/users/update_password/\(password.id)",
            method: .put,
            headers: [.contentJson],
            body: password)
    }
}
