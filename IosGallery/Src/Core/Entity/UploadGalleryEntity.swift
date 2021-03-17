//
//  UploadGalleryEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxNetworkApiClient

struct UploadGalleryEntity: JsonBodyConvertible {
    
    let name: String
    let dateCreate: String
    let description: String
    let new: Bool
    let popular: Bool
    let image: String
}
