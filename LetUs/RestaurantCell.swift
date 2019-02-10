//
//  RestaurantCell.swift
//  LetUs
//
//  Created by Sean Lu on 2/10/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!

    // MARK: - Properties
    var restaurant: Restaurant? {
        didSet {
            guard let restaurant = restaurant else { return }
            
            nameLabel.text = restaurant.name
            addressLabel.text = restaurant.address
            pictureImageView.image = restaurant.picture
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
