//
//  MenuItemCell.swift
//  LetUs
//
//  Created by Sean Lu on 3/14/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Properties
    var menuItem: MenuItem? {
        didSet {
            guard let menuItem = menuItem else { return }
            
            nameLabel.text = menuItem.name
            priceLabel.text = menuItem.price
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
