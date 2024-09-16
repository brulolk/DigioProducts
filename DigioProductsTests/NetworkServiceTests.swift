//
//  NetworkServiceTests.swift
//  DigioProductsTests
//
//  Created by Bruno Vinicius on 16/09/24.
//

import XCTest
@testable import DigioProducts

class MockURLSession: URLSession {
    var dataTaskResult: (data: Data?, response: URLResponse?, error: Error?) = (nil, nil, nil)

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(dataTaskResult.data, dataTaskResult.response, dataTaskResult.error)
        return URLSessionDataTask()
    }
}

class NetworkServiceTests: XCTestCase {

    var networkService: NetworkService!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkService = NetworkService(session: mockSession)
    }

    func testRequestSuccess() {
        let json = """
        {
            "name": "Spotlight Example",
            "bannerURL": "https://example.com/spotlight-banner.jpg",
            "description": "This is an example of a spotlight item."
        }
        """.data(using: .utf8)!
        mockSession.dataTaskResult = (data: json, response: nil, error: nil)

        let url = URL(string: "https://example.com")!
        networkService.request(url: url, method: .get, body: nil, responseType: Spotlight.self) { result in
            switch result {
            case .success(let spotlight):
                XCTAssertEqual(spotlight.name, "Spotlight Example")
                XCTAssertEqual(spotlight.bannerURL, "https://example.com/spotlight-banner.jpg")
                XCTAssertEqual(spotlight.description, "This is an example of a spotlight item.")
            case .failure(let error):
                XCTFail("Request failed with error: \(error)")
            }
        }
    }

    func testRequestFailure() {
        let testError = NSError(domain: "NetworkError", code: 1, userInfo: nil)
        mockSession.dataTaskResult = (data: nil, response: nil, error: testError)

        let url = URL(string: "https://example.com")!
        networkService.request(url: url, method: .get, body: nil, responseType: Spotlight.self) { result in
            switch result {
            case .success:
                XCTFail("Request should fail")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, testError.domain)
                XCTAssertEqual(error.code, testError.code)
            }
        }
    }

    func testRequestDecodingFailure() {
        let invalidJson = """
        { "invalidKey": "This will fail decoding" }
        """.data(using: .utf8)!
        mockSession.dataTaskResult = (data: invalidJson, response: nil, error: nil)

        let url = URL(string: "https://example.com")!
        networkService.request(url: url, method: .get, body: nil, responseType: Spotlight.self) { result in
            switch result {
            case .success:
                XCTFail("Request should fail due to decoding error")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError)
            }
        }
    }
}
