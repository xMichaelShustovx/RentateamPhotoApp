//
//  Photo+CoreDataProperties.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: String
    @NSManaged public var author: String
    @NSManaged public var image: Data?
    @NSManaged public var downloadDate: Date
    @NSManaged public var imageURL: String

}

extension Photo : Identifiable {

}
