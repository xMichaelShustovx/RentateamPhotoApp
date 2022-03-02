//
//  DetailViewController.swift
//  RentaPhotoApp
//
//  Created by Michael Shustov on 02.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var photo: Photo
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.backgroundColor = .black
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if let data = photo.image {
            imageView.image = UIImage(data: data)
        }
        else {
            imageView.image = UIImage(systemName: "nosign")
        }
        return imageView
    }()
    
    lazy var downloadDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Download Date: " + photo.downloadDate.formatted(date: .abbreviated, time: .shortened)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // MARK: - Initializers
    
    init(_ photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        [UIView(), photoImageView, downloadDateLabel, UIView()].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
