//
//  Networking.swift
//  simpletest
//
//  Created by H.W. Hsiao on 2021/1/23.
//

import Foundation

protocol NetworkingDelegate: AnyObject {
    func networking(_ network: Networking, getCategory: Category, getProduct: Product, getSale: Sale)
}

enum DataType: String, CaseIterable {
    case category = "https://blooming-oasis-01056.herokuapp.com/category"
    case product = "https://blooming-oasis-01056.herokuapp.com/product?id="
    case sale = "https://blooming-oasis-01056.herokuapp.com/sale?id="
}

class Networking {
    
    weak var networkDelegate: NetworkingDelegate?
    let queue1 = DispatchQueue(label: "category")
    let queue2 = DispatchQueue(label: "product")
    let queue3 = DispatchQueue(label: "sale")
    let group = DispatchGroup()
    
    var category: Category?
    var product: Product?
    var sale: Sale?
    
    func fetchData() {
        group.enter()
        queue1.async(group: group, qos: .background) {
            print("1-start")
            self.downloader(dataType: .category) {
                print("1-end")
                self.group.leave()
            }
        }
        group.wait()
        group.enter()
        queue2.async(group: group, qos: .background) {
            print("2-start")
            self.downloader(dataType: .product) {
                print("2-end")
                self.group.leave()
            }
        }
        group.wait()
        group.enter()
        queue3.async(group: group, qos: .background) {
            print("3-start")
            self.downloader(dataType: .sale) {
                print("3-end")
                self.group.leave()
            }
        }
        group.notify(queue: .main) { [self] in
            if let okCategory = category, let okProduct = product, let okSale = sale {
                print("4-delegate")
                networkDelegate?.networking(self, getCategory: okCategory, getProduct: okProduct, getSale: okSale)
            }
        }
    }

    private func downloader(dataType: DataType, completion: @escaping () -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        switch dataType {
        case .category:
            if let url = URL(string: dataType.rawValue) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let err = error {
                        print("Error downloaded category data: \(err)")
                    } else {
                        if let okData = data {
                            do {
                                self.category = try decoder.decode(Category.self, from: okData)
                                completion()
                            } catch {
                                print("Error parsed category data.")
                            }
                        }
                    }
                }.resume()
            }
        case .product:
            if let category = self.category {
                for i in 0 ..< category.data.shopCategoryList.count {
                    let id = category.data.shopCategoryList.categoryList[i].id
                    if let url = URL(string: dataType.rawValue + "\(id)") {
                        URLSession.shared.dataTask(with: url) { data, _, error in
                            if let err = error {
                                print("Error downloaded product data: \(err)")
                            } else {
                                do {
                                    if let okData = data {
                                        self.product = try decoder.decode(Product.self, from: okData)
                                        completion()
                                    }
                                } catch {
                                    print("Error parsed product data.")
                                }
                            }
                        }.resume()
                    }
                }
            }
        case .sale:
            if let category = self.category {
                for i in 0 ..< category.data.shopCategoryList.count {
                    let id = category.data.shopCategoryList.categoryList[i].id
                    if let url = URL(string: dataType.rawValue + "\(id)") {
                        URLSession.shared.dataTask(with: url) { data, _, error in
                            if let err = error {
                                print("Error downloaded sale data: \(err)")
                            } else {
                                do {
                                    if let okData = data {
                                        self.sale = try decoder.decode(Sale.self, from: okData)
                                        completion()
                                    }
                                } catch {
                                    print("Error parsed sale data.")
                                }
                            }
                        }.resume()
                    }
                }
            }
        }
    }
}
