//
//  CoreDataManager.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import Foundation
import UIKit
import CoreData


class CoreDataManager {
    
    // MARK: - Properties
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    static func fetchPhotos() -> [Photo] {
        do {
            let photos = try self.context.fetch(Photo.fetchRequest())
            return photos
        }
        catch {
            print("No photos in Core Data")
            return [Photo]()
        }
    }
    
    static func fetchPhoto(_ photo: Photo) -> Photo? {
        let fetchRequest = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id LIKE %@", photo.id)
        do {
            let photo = try self.context.fetch(fetchRequest).first
            return photo
        }
        catch {
            print("Error during photo search")
            return nil
        }
    }
    
    static func saveContext() {
        do {
            try context.save()
        }
        catch {
            print("Couldn't save to CoreData")
            print(error)
        }
    }
    
    static func deletePhoto(_ photo: Photo) {
        context.delete(photo)
    }
    
    static func deletePhotos(_ photos: [Photo]) {
        photos.forEach { context.delete($0) }
    }
    
    static func clearDB() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
            print("DB cleared")
            print("Current amount of elements: \(self.fetchPhotos().count)")
        }
        catch
        {
            print ("There was an error")
        }
        
    }
}
