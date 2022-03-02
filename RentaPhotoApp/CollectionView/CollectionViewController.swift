//
//  ViewController.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import UIKit


class CollectionViewController: UIViewController {
    
    // MARK: - Properties
    
    var model = PhotosModel()
    lazy var photos = model.photos
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (self.view.frame.size.width / 3) - 1, height: (self.view.frame.size.width / 3) - 1)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .gray
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        model.delegate = self
        if photos.count == 0 {
            model.getPhotos()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.flashScrollIndicators()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        title = "Welcome to Unsplash"
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
