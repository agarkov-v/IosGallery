//
//  GalleryEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

struct GalleryEntity: Codable {
    
    let name: String
    let dateCreate: String
    let description: String
    let new: Bool?
    let popular: Bool?
    let image: ImageEntity
    let user: String?
}
