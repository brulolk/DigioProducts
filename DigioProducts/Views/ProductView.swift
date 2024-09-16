//
//  ProductView.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

class ProductView: UIView {

    private let imageView = UIImageView()
    private var callback: ((Product) -> Void)?
    private var product: Product?

    init(product: Product, callback: ((Product) -> Void)? = nil) {
        super.init(frame: .zero)
        self.callback = callback
        setupView()
        configure(with: product)
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let bannerSize = UIScreen.main.bounds.width/3
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: bannerSize),
            self.widthAnchor.constraint(equalToConstant: bannerSize)
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        guard let product = product else { return }
        callback?(product)
    }
    
    private func configure(with product: Product) {
        self.product = product
        guard let url = URL(string: product.imageURL) else { return }
        self.showSkeleton()
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            self?.imageView.image = image
            self?.hideSkeleton()
        }
    }
}
