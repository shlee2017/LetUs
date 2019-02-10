//
//  RestaurantData.swift
//  LetUs
//
//  Created by Sean Lu on 2/3/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import Foundation
import UIKit

final class RestaurantData {
    
    static func generateRestaurantData() -> [Restaurant] {
        return [
            Restaurant(name: "Pizza House", address: "618 Church St, Ann Arbor, MI 48104", picture: UIImage(named:"pizzahouse.jpg")),
            Restaurant(name: "Zingerman's Roadhouse", address: "2501 Jackson Ave, Ann Arbor, MI 48103", picture: UIImage(named:"zingermans.jpg"))
        ]
    }
}
