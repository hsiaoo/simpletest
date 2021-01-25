//
//  Product.swift
//  simpletest
//
//  Created by H.W. Hsiao on 2021/1/23.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    var data: ProductData
}

// MARK: - DataClass
struct ProductData: Codable {
    var shopCategory: ProductCategory
}

// MARK: - ShopCategory
struct ProductCategory: Codable {
    var salePageList: ProductCategorySalePageList
}

// MARK: - ShopCategorySalePageList
struct ProductCategorySalePageList: Codable {
    var salePageList: [ProductPageListElement]
}

// MARK: - SalePageListElement
struct ProductPageListElement: Codable {
    let salePageID: Int
    let title: String
    let price, suggestPrice: Int

    enum CodingKeys: String, CodingKey {
        case salePageID = "salePageId"
        case title, price, suggestPrice
    }
}
