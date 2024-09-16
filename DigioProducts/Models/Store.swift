//
//  Store.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import Foundation

public struct Spotlight: Codable, Equatable {
    public let name: String
    public let bannerURL: String
    public let description: String

    public init(name: String, bannerURL: String, description: String) {
        self.name = name
        self.bannerURL = bannerURL
        self.description = description
    }
}

public struct Product: Codable, Equatable {
    public let name: String
    public let imageURL: String
    public let description: String

    public init(name: String, imageURL: String, description: String) {
        self.name = name
        self.imageURL = imageURL
        self.description = description
    }
}

public struct Cash: Codable, Equatable {
    public let title: String
    public let bannerURL: String
    public let description: String

    public init(title: String, bannerURL: String, description: String) {
        self.title = title
        self.bannerURL = bannerURL
        self.description = description
    }
}

public struct Store: Codable, Equatable {
    public let spotlight: [Spotlight]
    public let products: [Product]
    public let cash: Cash

    public init(spotlight: [Spotlight], products: [Product], cash: Cash) {
        self.spotlight = spotlight
        self.products = products
        self.cash = cash
    }
}

// Mocks
private let mockSpotlight = Spotlight(
    name: "Spotlight Example",
    bannerURL: "https://example.com/spotlight-banner.jpg",
    description: "This is an example of a spotlight item."
)

private let mockProduct = Product(
    name: "Product Example",
    imageURL: "https://example.com/product-image.jpg",
    description: "This is an example of a product item."
)

private let mockCash = Cash(
    title: "Cash Example",
    bannerURL: "https://example.com/cash-banner.jpg",
    description: "This is an example of a cash item."
)

let mockStore = Store(
    spotlight: [mockSpotlight],
    products: [mockProduct],
    cash: mockCash
)

let mockError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"])

