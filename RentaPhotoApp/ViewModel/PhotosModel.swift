//
//  PhotosModel.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import Foundation

protocol PhotosModelDelegate: AnyObject {
    func dataUpdated()
}


class PhotosModel: NetworkManagerProtocol {

    // MARK: - Properties
    
    weak var delegate: PhotosModelDelegate?
    
    var photos = [Photo]()
    private let networkManager = NetworkManager()
    private var isPaginating = false
    
    // MARK: - Initialization
    
    init() {
        networkManager.delegate = self
        self.photos = CoreDataManager.fetchPhotos()
    }
    
    // MARK: - Public Methods
    
    func getPhotos() {
        if !isPaginating {
            isPaginating = true
            networkManager.getPhotos()
        }
    }
    
    // MARK: - NetworkManagerProtocol Methods
    
    func photosRetrieved(data: Data?) {
        if let data = data {
            if let recievedPhotos = JSONParseManager.parsePhotos(data: data) {
                self.photos = recievedPhotos
                self.networkManager.getPhotosImages(for: recievedPhotos)
            }
        }
    }
    
    func photosImagesRetrieved(photos: [Photo]) {
        
        CoreDataManager.saveContext()
        print("Data updated")
        delegate?.dataUpdated()
        isPaginating = false
    }
}
