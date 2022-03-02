//
//  JSONParseManager.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import Foundation
import UIKit


class JSONParseManager {
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    static func parsePhotos(data: Data) -> [Photo]? {
        
        do {
            let results = try JSONDecoder().decode([Result].self, from: data)
            
            var photoArray = [Photo]()
            
            results.forEach { result in
                
                let photo = JSONParseManager.parseAsPhoto(result: result)

                photoArray.append(photo)
            }
            
            return photoArray
        }
        catch {
            print("Couldn't parse Photos")
            print(error)
            return nil
        }
    }
    
    private static func parseAsPhoto(result: Result) -> Photo {
        
        let photo = Photo(context: CoreDataManager.context)
        photo.id = result.id
        photo.author = result.user.name
        photo.imageURL = result.urls.small
        photo.downloadDate = .now
        
        return photo
    }
}
