//
//  PhotoCollectionViewCell.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PhotoCell"
    
    var photo: Photo? {
        didSet {
            if let data = photo?.image {
                photoImageView.image = UIImage(data: data)
            }
            else {
                photoImageView.image = UIImage(systemName: "nosign")
            }
            
            authorLabel.text = photo?.author
        }
    }
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "nosign")
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = .black
    }
    
    private func setupCell() {
        [photoImageView, authorLabel].forEach{ contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: authorLabel.topAnchor),
//            photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 4 / 5),
            
            authorLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            authorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
