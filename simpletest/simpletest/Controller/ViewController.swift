//
//  ViewController.swift
//  simpletest
//
//  Created by Michael Chang on 2021/1/15.
//

import UIKit

enum Filter {
    case normal, isSoldOut, isComingSoon
}

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    
    
    let networking = Networking()
    var filterType = Filter.normal
    var category: Category?
    
    var product = [ProductPageListElement]()
    var sale = [SalePageListElement]()
    var orderProduct = [ProductPageListElement]()
    var orderSale = [SalePageListElement]()
    
    var soldOutProduct = [ProductPageListElement]()
    var soldOutSale = [SalePageListElement]()
    var comingSoonProduct = [ProductPageListElement]()
    var comingSoonSale = [SalePageListElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networking.networkDelegate = self
        networking.fetchData()
    }
    
    @IBAction func soldOutFilter(_ sender: Any) {
        if filterType == .normal {
            filterType = .isSoldOut
        } else {
            filterType = .normal
        }
        myTableView.reloadData()
    }
    
    @IBAction func comingSoonFilter(_ sender: Any) {
        if filterType == .normal {
            filterType = .isComingSoon
        } else {
            filterType = .normal
        }
        myTableView.reloadData()
    }
    
    @IBAction func orderSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //product and orderSale, 高價>低價
            priceDescending()
        case 1:
            //product and orderSale, 低價>高價
            priceAscending()
        case 2:
            //orderProduct and sale, 銷售時間新>舊
            dateDescending()
        case 3:
            //orderProduct and sale, 銷售時間舊>新
            dateAscending()
        default: break
        }
    }
    
    func priceDescending() {
        orderSale.removeAll()
        switch filterType {
        case .normal:
            product.sort(by: { (product1, product2) -> Bool in
                product1.price > product2.price
            })
            
            for productItem in product {
                for saleItem in sale {
                    if productItem.salePageID == saleItem.salePageID {
                        orderSale.append(saleItem)
                    }
                }
            }
        case .isSoldOut:
            soldOutProduct.sort(by: { (product1, product2) -> Bool in
                product1.price > product2.price
            })
            
            for productItem in soldOutProduct {
                for saleItem in soldOutSale {
                    if productItem.salePageID == saleItem.salePageID {
                        orderSale.append(saleItem)
                    }
                }
            }
        case .isComingSoon:
            comingSoonProduct.sort(by: { (product1, product2) -> Bool in
                product1.price > product2.price
            })
            
            for productItem in comingSoonProduct {
                for saleItem in comingSoonSale {
                    if productItem.salePageID == saleItem.salePageID {
                        orderSale.append(saleItem)
                    }
                }
            }
        }
        myTableView.reloadData()
    }
    
    func priceAscending() {
        orderSale.removeAll()
        switch filterType {
        case .normal:
            product.sort(by: { (product1, product2) -> Bool in
                product1.price < product2.price
            })
            
            for productItem in product {
                for saleItem in sale {
                    if productItem.salePageID == saleItem.salePageID {
                        orderSale.append(saleItem)
                    }
                }
            }
        case .isSoldOut:
            soldOutProduct.sort(by: { (product1, product2) -> Bool in
                product1.price <  product2.price
            })
            
            for productItem in soldOutProduct {
                for saleItem in soldOutSale {
                    if productItem.salePageID == saleItem.salePageID {
                        orderSale.append(saleItem)
                    }
                }
            }
        case .isComingSoon:
            comingSoonProduct.sort(by: { (product1, product2) -> Bool in
                product1.price <  product2.price
            })
            
            for productItem in comingSoonProduct {
                for saleItem in comingSoonSale {
                    if productItem.salePageID == saleItem.salePageID {
                        orderSale.append(saleItem)
                    }
                }
            }
        }
        myTableView.reloadData()
    }
    
    func dateDescending() {
        orderProduct.removeAll()
        switch filterType {
        case .normal:
            sale.sort { (sale1, sale2) -> Bool in
                sale1.sellingStartDateTime.compare(sale2.sellingStartDateTime) == ComparisonResult.orderedDescending
            }
            
            for saleItem in sale {
                for productItem in product {
                    if saleItem.salePageID == productItem.salePageID {
                        orderProduct.append(productItem)
                    }
                }
            }
            
        case .isSoldOut:
            soldOutSale.sort { (sale1, sale2) -> Bool in
                sale1.sellingStartDateTime.compare(sale2.sellingStartDateTime) == ComparisonResult.orderedDescending
            }
            
            for saleItme in soldOutSale {
                for productItem in soldOutProduct {
                    if saleItme.salePageID == productItem.salePageID {
                        orderProduct.append(productItem)
                    }
                }
            }
            
        case .isComingSoon:
            comingSoonSale.sort { (sale1, sale2) -> Bool in
                sale1.sellingStartDateTime.compare(sale2.sellingStartDateTime) == ComparisonResult.orderedDescending
            }
            
            for saleItem in comingSoonSale {
                for productItem in comingSoonProduct {
                    if saleItem.salePageID == productItem.salePageID {
                        orderProduct.append(productItem)
                    }
                }
            }
        }
        myTableView.reloadData()
    }
    
    func dateAscending() {
        orderProduct.removeAll()
        switch filterType {
        case .normal:
            sale.sort { (sale1, sale2) -> Bool in
                sale1.sellingStartDateTime.compare(sale2.sellingStartDateTime) == ComparisonResult.orderedAscending
            }
            
            for saleItem in sale {
                for productItem in product {
                    if saleItem.salePageID == productItem.salePageID {
                        orderProduct.append(productItem)
                    }
                }
            }
            
        case .isSoldOut:
            soldOutSale.sort { (sale1, sale2) -> Bool in
                sale1.sellingStartDateTime.compare(sale2.sellingStartDateTime) == ComparisonResult.orderedAscending
            }
            
            for saleItem in soldOutSale {
                for productItem in soldOutProduct {
                    if saleItem.salePageID == productItem.salePageID {
                        orderProduct.append(productItem)
                    }
                }
            }
            
        case .isComingSoon:
            comingSoonSale.sort { (sale1, sale2) -> Bool in
                sale1.sellingStartDateTime.compare(sale2.sellingStartDateTime) == ComparisonResult.orderedAscending
            }
            
            for saleItem in comingSoonSale {
                for productItem in comingSoonProduct {
                    if saleItem.salePageID == productItem.salePageID {
                        orderProduct.append(productItem)
                    }
                }
            }
        }
        myTableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let category = category else { return 1 }
        return category.data.shopCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch filterType {
        case .normal: return product.count
        case .isSoldOut: return soldOutProduct.count
        case .isComingSoon: return comingSoonProduct.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let productCell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell {
            
            switch mySegment.selectedSegmentIndex {
            case 0, 1:
                productCell.nameLabel.text = product[indexPath.row].title
                productCell.suggestPriceLabel.text = product[indexPath.row].suggestPrice.description
                productCell.quantityLabel.text = orderSale[indexPath.row].sellingQty.description
                productCell.startDateLabel.text = orderSale[indexPath.row].sellingStartDateTime.description
                
                let price = product[indexPath.row].price
                if price > 200 {
                    productCell.priceLabel.textColor = .red
                } else {
                    productCell.priceLabel.textColor = .black
                }
                productCell.priceLabel.text = price.description
                
                return productCell
                
            case 2, 3:
                productCell.nameLabel.text = orderProduct[indexPath.row].title
                productCell.suggestPriceLabel.text = orderProduct[indexPath.row].suggestPrice.description
                productCell.quantityLabel.text = sale[indexPath.row].sellingQty.description
                productCell.startDateLabel.text = sale[indexPath.row].sellingStartDateTime.description
                
                let price = orderProduct[indexPath.row].price
                if price > 200 {
                    productCell.priceLabel.textColor = .red
                } else {
                    productCell.priceLabel.textColor = .black
                }
                productCell.priceLabel.text = price.description
                
                return productCell
                
            default: return productCell
            }
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: NetworkingDelegate {
    func networking(_ network: Networking, getCategory: Category, getProduct: Product, getSale: Sale) {
        category = getCategory
        product = getProduct.data.shopCategory.salePageList.salePageList
        sale = getSale.data.shopCategory.salePageList.salePageList
        
        soldOutSale = getSale.data.shopCategory.salePageList.salePageList.filter({ (saleItem) -> Bool in
            saleItem.isSoldOut == true
        })
        
        for saleItme in soldOutSale  {
            for product in getProduct.data.shopCategory.salePageList.salePageList {
                if saleItme.salePageID == product.salePageID {
                    soldOutProduct.append(product)
                }
            }
        }
        
        comingSoonSale = getSale.data.shopCategory.salePageList.salePageList.filter({ (saleItem) -> Bool in
            saleItem.isComingSoon == true
        })
        
        for saleItem in comingSoonSale {
            for product in getProduct.data.shopCategory.salePageList.salePageList {
                if saleItem.salePageID == product.salePageID {
                    comingSoonProduct.append(product)
                }
            }
        }
        
        priceDescending()
        
//        print("category: \(getCategory)")
//        print("=================")
//        print("product: \(getProduct)")
//        print("=================")
//        print("sale: \(getSale)")
//        print("=================")
//        print("sold out sale: \(soldOutSale)")
//        print("=================")
//        print("sold out product: \(soldOutProduct)")
//        print("=================")
//        print("coming soon sale: \(comingSoonSale)")
//        print("=================")
//        print("coming soon product: \(comingSoonProduct)")
    }
    
}

