//
//  CarouselView.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

class CarouselView: UIView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        clipsToBounds = false
        scrollView.clipsToBounds = false
        stackView.clipsToBounds = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func configure(with views: [UIView]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        views.forEach { view in
            addShadow(to: view)
            let containerView = createContainerView(for: view)
            stackView.addArrangedSubview(containerView)
        }
    }
    
    private func createContainerView(for view: UIView) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(view)
        containerView.clipsToBounds = false
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            view.widthAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return containerView
    }

    private func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
    }
}
