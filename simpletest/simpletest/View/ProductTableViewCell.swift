//
//  ProductTableViewCell.swift
//  simpletest
//
//  Created by H.W. Hsiao on 2021/1/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "productCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var suggestPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
