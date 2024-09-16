//
//  StoreViewModelTests.swift
//  DigioProductsTests
//
//  Created by Bruno Vinicius on 16/09/24.
//

import XCTest
@testable import DigioProducts

final class StoreViewModelTests: XCTestCase {
    
    var viewModel: StoreViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = StoreViewModel(networkService: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testLoadDataSuccess() {
        let mockStore = mockStore
        
        let expectation = XCTestExpectation(description: "Data loaded")
        
        viewModel.dataDidUpdate = {
            expectation.fulfill()
        }
        
        viewModel.loadDataMock(success: true)
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.spotlights, mockStore.spotlight)
        XCTAssertEqual(viewModel.products, mockStore.products)
        XCTAssertEqual(viewModel.cash, mockStore.cash)
    }
    
    func testLoadDataFailure() {
        let mockError = mockError
        
        let expectation = XCTestExpectation(description: "Data failed to load")
        
        viewModel.dataDidUpdate = {
            expectation.fulfill()
        }
        
        viewModel.loadDataMock(success: false)
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.error as NSError?, mockError)
        XCTAssertTrue(viewModel.spotlights.isEmpty)
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNil(viewModel.cash)
    }
}

class MockNetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, body: Data?, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    }
}

