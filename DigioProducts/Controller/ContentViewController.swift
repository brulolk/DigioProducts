//
//  ContentViewController.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 15/09/24.
//

import UIKit

enum ContentType {
    case product(Product)
    case spotlight(Spotlight)
    case cash(Cash)
}

class ContentViewController: UIViewController {
    
    private var contentType: ContentType
    private let bannerWidth = UIScreen.main.bounds.width - 30
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "titulo"
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Verdana", size: 14)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.text = "descrição"
        return label
    }()


    init(contentType: ContentType) {
        self.contentType = contentType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        switch contentType {
        case .product(let product):
            setupProductView(with: product)
        case .spotlight(let spotlight):
            setupSpotlightView(with: spotlight)
        case .cash(let cash):
            setupCashView(with: cash)
        }
    }
    
    private func setupProductView(with product: Product) {
        titleLabel.text = product.name
        descriptionLabel.text = product.description
        loadImage(with: URL(string: product.imageURL))
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupSpotlightView(with spotlight: Spotlight) {
        titleLabel.text = spotlight.name
        descriptionLabel.text = spotlight.description
        loadImage(with: URL(string: spotlight.bannerURL))
        
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: bannerWidth),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupCashView(with cash: Cash) {
        titleLabel.text = cash.title
        descriptionLabel.text = cash.description
        loadImage(with: URL(string: cash.bannerURL))
        
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: bannerWidth),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/3.49),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func loadImage(with url: URL?) {
        guard let url = url else {
            imageView.isHidden = true
            return
        }
        imageView.showSkeleton()
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            guard let self = self, let image = image else { return }
            self.imageView.image = image
            self.imageView.hideSkeleton()
        }
    }
}
