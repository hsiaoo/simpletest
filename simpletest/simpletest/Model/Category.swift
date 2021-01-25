//
//  Category.swift
//  simpletest
//
//  Created by H.W. Hsiao on 2021/1/23.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let data: CategoryData
}

// MARK: - CategoryStruct
struct CategoryData: Codable {
    let shopCategoryList: ShopCategoryList
}

// MARK: - ShopCategoryList
struct ShopCategoryList: Codable {
    let count: Int
    let categoryList: [CategoryList]
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let id: Int
    let name: String
}
