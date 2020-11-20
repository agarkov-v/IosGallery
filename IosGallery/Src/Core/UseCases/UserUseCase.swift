//
//  UserUseCase.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 22.10.2020.
//

import RxSwift

protocol UserUseCase {
    
    func uploadGalleryItem(image: UIImage, name: String, description: String) -> Completable
}

class UserUseCaseImp: UserUseCase {
    
    private let fileGateway: ImageGateway
    private let galleryGateway: GalleryGateway
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    init(fileGateway: ImageGateway, galleryGateway: GalleryGateway) {
        self.fileGateway = fileGateway
        self.galleryGateway = galleryGateway
    }
    
    func uploadGalleryItem(image: UIImage, name: String, description: String) -> Completable {
        guard let data = image.pngData() else {
            return .error(AppError.imageToPngError)
        }
        
        return fileGateway.uploadFile(data: data)
            .flatMapCompletable { [weak self] (file) -> Completable in
                guard let self = self else {
                    return Completable.empty()
                }
                
                let date = self.dateFormatter.string(from: Date())
                
                let imageIri = "http://gallery.dev.webant.ru/api/media_objects/\(file.id)"
                
                let galleryPost = UploadGalleryEntity(name: name,
                                                      dateCreate: date,
                                                      description: description,
                                                      new: true,
                                                      popular: false,
                                                      image: imageIri)
                return self.galleryGateway.createPost(gallery: galleryPost)
                    .asCompletable()
            }
    }
}

