//
//  ApiGalleryGateway.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxSwift

protocol GalleryGateway {

    func getPhotos(page: Int, limit: Int, type: GalleryType, searchBy text: String?) -> Single<PaginationEntity<GalleryEntity>>
    
    func createPost(gallery: UploadGalleryEntity) -> Single<ImageEntity>
    
    func getUserPhotos(page: Int, limit: Int, userId: Int) -> Single<PaginationEntity<GalleryEntity>>
    
//    func editPhoto() -> Single<GalleryResponse>
//    func deletePhoto() -> Completable
}

class ApiGalleryGateway: ApiBaseGateway, GalleryGateway {
    
    func getPhotos(page: Int, limit: Int, type: GalleryType, searchBy text: String? = nil) -> Single<PaginationEntity<GalleryEntity>> {
        return self.apiClient.execute(request: .getPhotos(page: page, limit: limit, type: type, searchBy: text))
    }
    
    func createPost(gallery: UploadGalleryEntity) -> Single<ImageEntity> {
        return self.apiClient.execute(request: .uploadGallery(gallery: gallery))
    }
    
    func getUserPhotos(page: Int, limit: Int, userId: Int) -> Single<PaginationEntity<GalleryEntity>> {
        return self.apiClient.execute(request: .getPhotos(page: page, limit: limit, userId: userId))
    }
    
//
//    func editPhoto() -> Single<GalleryResponse> {
//
//    }
//
//    func deletePhoto() -> Completable {
//
//    }
    
    
}
