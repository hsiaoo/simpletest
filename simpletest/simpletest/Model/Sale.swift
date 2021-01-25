//
//  Sale.swift
//  simpletest
//
//  Created by H.W. Hsiao on 2021/1/23.
//

import Foundation

// MARK: - Sale
struct Sale: Codable {
    var data: SaleData
}

// MARK: - DataClass
struct SaleData: Codable {
    var shopCategory: ShopCategory
}

// MARK: - ShopCategory
struct ShopCategory: Codable {
    var salePageList: ShopCategorySalePageList
}

// MARK: - ShopCategorySalePageList
struct ShopCategorySalePageList: Codable {
    var salePageList: [SalePageListElement]
}

// MARK: - SalePageListElement
struct SalePageListElement: Codable {
    let salePageID, sellingQty: Int
    let isSoldOut, isComingSoon: Bool
    let sellingStartDateTime: Date

    enum CodingKeys: String, CodingKey {
        case salePageID = "salePageId"
        case sellingQty, isSoldOut, isComingSoon, sellingStartDateTime
    }
}
