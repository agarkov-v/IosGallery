//
//  ApiImageGateway.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

import RxNetworkApiClient
import RxSwift

protocol ImageGatewayProtocol {
    
    func uploadFile(data: Data) -> Single<ImageEntity>
}


class ApiImageGateway: ApiBaseGateway, ImageGatewayProtocol {
    
    func uploadFile(data: Data) -> Single<ImageEntity> {
        return .deferred {
            let file = UploadFile("file", data, "image")
            let request = ApiRequest<ImageEntity>.uploadFile(file: file)
            request.responseTimeout = 120
            return self.apiClient.execute(request: request)
        }
    }
}
