//
//  ServiceView.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

enum ServiceKind {
    case cash, spotlight
}

class ServiceView: UIView {
    private let imageView = UIImageView()
    private var imageAspectRatioConstraint: NSLayoutConstraint?
    private var kind: ServiceKind?
    private var callbackSpotlight: ((Spotlight) -> Void)?
    private var spotlight: Spotlight?
    private var callbackCash: ((Cash) -> Void)?
    private var cash: Cash?

    init(spotlight: Spotlight, callback: ((Spotlight) -> Void)? = nil) {
        super.init(frame: .zero)
        self.callbackSpotlight = callback
        configure(with: spotlight)
    }
    
    init(cash: Cash, callback: ((Cash) -> Void)? = nil) {
        super.init(frame: .zero)
        self.callbackCash = callback
        configure(with: cash)
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func setupView(with kind: ServiceKind = .spotlight) {
        backgroundColor = .white
        layer.cornerRadius = 20
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let bannerWidth = UIScreen.main.bounds.width - 30
        switch kind {
        case .cash:
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: bannerWidth),
                self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3.49)
            ])
        case .spotlight:
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: bannerWidth),
                self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
            ])
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        guard let kind = kind else { return }
        switch kind {
        case .cash:
            guard let cash = cash else { return }
            callbackCash?(cash)
        case .spotlight:
            guard let spotlight = spotlight else { return }
            callbackSpotlight?(spotlight)
        }
    }
    
    public func configure(with spotlight: Spotlight) {
        self.spotlight = spotlight
        self.kind = .spotlight
        setupView(with: .spotlight)
        guard let url = URL(string: spotlight.bannerURL) else { return }
        loadImage(with: url)
        guard let _ = callbackSpotlight else { return }
        setupTapGesture()
    }
    
    public func configure(with cash: Cash) {
        self.cash = cash
        self.kind = .cash
        setupView(with: .cash)
        guard let url = URL(string: cash.bannerURL) else { return }
        loadImage(with: url)
        guard let _ = callbackCash else { return }
        setupTapGesture()
    }
    
    private func loadImage(with url: URL) {
        self.showSkeleton()
        ImageLoader.shared.loadImage(from: url) { [weak self] image in
            guard let self = self, let image = image else { return }
            self.imageView.image = image
            self.hideSkeleton()
        }
    }
}
