//
//  PhotoJSON.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import Foundation

typealias PhotosJSON = Results

struct Results: Decodable {
    var total: Int
    var results: [Result]
}

struct Result: Decodable {
    var id: String
    var created_at: String
    var user: User
    var urls: URLs
}

struct User: Decodable {
    var name: String
}

struct URLs: Decodable {
    var small: String
}
