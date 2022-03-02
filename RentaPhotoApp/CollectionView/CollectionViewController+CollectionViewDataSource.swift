//
//  CollectionViewController+DataSource.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import UIKit


extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK:  - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photo =  self.photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(self.photos[indexPath.item]), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (self.collectionView.contentSize.height - 100 - scrollView.frame.height) {
            self.model.getPhotos()
        }
    }
}

