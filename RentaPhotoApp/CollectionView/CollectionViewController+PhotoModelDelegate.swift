//
//  CollectionViewController+PhotoModelDelegate.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import Foundation


extension CollectionViewController: PhotosModelDelegate {
    
    // MARK: - PhotosModelDelegate
    
    func dataUpdated() {
        DispatchQueue.main.async {
            self.photos.append(contentsOf: self.model.photos) 
            self.collectionView.reloadData()
        }
    }
}
