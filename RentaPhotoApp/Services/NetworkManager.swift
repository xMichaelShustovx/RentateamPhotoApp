//
//  NetworkManager.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import Foundation


protocol NetworkManagerProtocol: AnyObject {
    
    func photosRetrieved(data: Data?)
    func photosImagesRetrieved(photos: [Photo])
}

class NetworkManager {
    
    // MARK: - Properties
    
    weak var delegate: NetworkManagerProtocol?
    
    private let key = "md0OYnyRYpRWENPnAu0PiBGwVBUzjGLIx66PrtG1TQ4"
    
    // MARK: - Public Methods
    
    func getPhotos() {
        
        let url = URL(string: "https://api.unsplash.com/photos/random?count=30")
        
        guard url != nil else { return }
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(key)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil && data != nil {
                
                self.delegate?.photosRetrieved(data: data)
            }
            else {
                print("Couldn't resume data task to get photos")
                self.delegate?.photosRetrieved(data: nil)
            }
        }
        
        dataTask.resume()
    }
    
    func getPhotosImages(for photos: [Photo]) {
        
//        let recievedPhotos = photos
        
        let queueConcurrent = DispatchQueue(label: "LoadImage", attributes: .concurrent)
        let group = DispatchGroup()
        
        photos.forEach { photo in
            
            group.enter()
            
            queueConcurrent.async {
                if let url = URL(string: photo.imageURL) {
                    let data = try? Data(contentsOf: url)
                    photo.image = data ?? Data()
                }
                
                group.leave()
            }
        }
        
        group.wait()
        
        delegate?.photosImagesRetrieved(photos: photos)
    }
}

