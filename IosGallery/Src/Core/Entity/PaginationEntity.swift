//
//  PaginationEntity.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import Foundation

struct PaginationEntity<T: Codable>: Codable {
    
    let countOfPages: Int
    let data: [T]
}
