//
//  UploadImageEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxNetworkApiClient

struct UploadImageEntity: JsonBodyConvertible {
    
    let name: String
    let data: Data
}
