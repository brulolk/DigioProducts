//
//  StoreModelTests.swift
//  DigioProductsTests
//
//  Created by Bruno Vinicius on 16/09/24.
//

import XCTest
@testable import DigioProducts

class StoreModelTests: XCTestCase {

    func testSpotlightDecoding() {
        let json = """
        {
            "name": "Spotlight Example",
            "bannerURL": "https://example.com/spotlight-banner.jpg",
            "description": "This is an example of a spotlight item."
        }
        """.data(using: .utf8)!

        do {
            let spotlight = try JSONDecoder().decode(Spotlight.self, from: json)
            XCTAssertEqual(spotlight.name, "Spotlight Example")
            XCTAssertEqual(spotlight.bannerURL, "https://example.com/spotlight-banner.jpg")
            XCTAssertEqual(spotlight.description, "This is an example of a spotlight item.")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

    func testProductEncoding() {
        let product = Product(name: "Product Example", imageURL: "https://example.com/product-image.jpg", description: "This is an example of a product item.")
        let encoder = JSONEncoder()

        do {
            let jsonData = try encoder.encode(product)
            let jsonString = String(data: jsonData, encoding: .utf8)
            XCTAssertTrue(jsonString?.contains("Product Example") == true)
        } catch {
            XCTFail("Encoding failed with error: \(error)")
        }
    }

    func testStoreInitialization() {
        let store = Store(
            spotlight: [Spotlight(name: "Spotlight Example", bannerURL: "https://example.com/spotlight-banner.jpg", description: "This is an example of a spotlight item.")],
            products: [Product(name: "Product Example", imageURL: "https://example.com/product-image.jpg", description: "This is an example of a product item.")],
            cash: Cash(title: "Cash Example", bannerURL: "https://example.com/cash-banner.jpg", description: "This is an example of a cash item.")
        )
        
        XCTAssertEqual(store.spotlight.count, 1)
        XCTAssertEqual(store.products.count, 1)
        XCTAssertEqual(store.cash.title, "Cash Example")
    }
}
