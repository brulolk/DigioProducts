//
//  StoreViewModel.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import Foundation

protocol StoreViewModelProtocol {
    var spotlights: [Spotlight] { get }
    var products: [Product] { get }
    var cash: Cash? { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    var dataDidUpdate: (() -> Void)? { get set }
    
    func loadData()
}

final class StoreViewModel: StoreViewModelProtocol {
    private let networkService: NetworkServiceProtocol
    private(set) var spotlights: [Spotlight] = []
    private(set) var products: [Product] = []
    private(set) var cash: Cash?
    
    private(set) var isLoading: Bool = false {
        didSet {
            dataDidUpdate?()
        }
    }
    
    private(set) var error: Error? {
        didSet {
            dataDidUpdate?()
        }
    }
    
    var data: Store? {
        didSet {
            self.spotlights = data?.spotlight ?? []
            self.cash = data?.cash
            self.products = data?.products ?? []
            dataDidUpdate?()
        }
    }
        
    var dataDidUpdate: (() -> Void)?

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func loadData() {
        isLoading = true
        error = nil
        
        guard let storeUrl = URL(string: APIConstants.baseURL) else { return self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "fail to get url"]) }
        
        networkService.request(url: storeUrl, method: .get, body: nil, responseType: Store.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let storeResponse):
                    self?.data = storeResponse
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
    
    func loadDataMock(success: Bool) {
        if success {
            data = mockStore
        } else {
            error = mockError
        }
    }
}
