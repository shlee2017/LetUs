//
//  CustomizationCell.swift
//  LetUs
//
//  Created by Sean Lu on 3/31/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class CustomizationCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    
    // MARK: - Properties
    var customization: CustomizationItem? {
        didSet {
            guard let customization = customization else { return }
            
            nameLabel.text = customization.name
            priceLabel.text = customization.price
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
