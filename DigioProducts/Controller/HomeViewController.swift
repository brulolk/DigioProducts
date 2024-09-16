//
//  HomeViewController.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var viewModel: StoreViewModelProtocol!
    private let networkService = NetworkService()
    
    @IBOutlet private weak var table: ModularTableView?
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupActivityIndicator()
        viewModel = StoreViewModel(networkService: networkService)
        viewModel.dataDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func updateUI() {
        if viewModel.isLoading {
            activityIndicator.startAnimating()
        } else if let error = viewModel.error {
            showError(error)
        } else {
            setupUI()
            activityIndicator.stopAnimating()
        }
    }
    
    private func setupUI() {
        var cellControllers: [CellController] = []
        
        cellControllers.append(contentsOf: [
            SpacingCellController(height: 10),
            SpotlightListCellController(list: viewModel.spotlights, 
                                        action: { [weak self] spotlight in
                let contentController = ContentViewController(contentType: .spotlight(spotlight))
                self?.callContentViewController(with: contentController)
            })
        ])
        
        if let cash = viewModel.cash {
            cellControllers.append(contentsOf: [
                SpacingCellController(height: 16),
                TitleCellController(title: "DigioCash"),
                SpacingCellController(height: 10),
                CashBannerCellController(cash: cash, 
                                         action: { [weak self] cash in
                    let contentController = ContentViewController(contentType: .cash(cash))
                    self?.callContentViewController(with: contentController)
                })
            ])
        }
        
        cellControllers.append(contentsOf: [
            SpacingCellController(height: 16),
            TitleCellController(title: "Produtos"),
            SpacingCellController(height: 10),
            ProductListCellController(list: viewModel.products, 
                                      action: { [weak self] product in
                let contentController = ContentViewController(contentType: .product(product))
                self?.callContentViewController(with: contentController)
            })
        ])
        
        table?.cellControllers = cellControllers
    }
    
    private func callContentViewController(with controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setupNavigationBar() {
        let containerView = UIView()
            
        let iconImageView = UIImageView(image: UIImage(named: "digio_ic"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)
            
        let textLabel = UILabel()
        textLabel.text = "Olá, Bruno"
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(textLabel)
            
        containerView.translatesAutoresizingMaskIntoConstraints = false
            
        let customBarButtonItem = UIBarButtonItem(customView: containerView)
        navigationItem.leftBarButtonItem = customBarButtonItem
            
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
                
            textLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            textLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Infelizmente não pudemos finalizar sua solicitação", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
