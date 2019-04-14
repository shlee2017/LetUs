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
            Restaurant(name: "Chipotle", address: "235 S N State St, Ann Arbor, MI 48104", picture: UIImage(named:"chipotle.png")),
            Restaurant(name: "Panera", address: "777 N University Ave, Ann Arbor, MI 48104", picture: UIImage(named:"panera.png")),
            Restaurant(name: "Jerusalem Garden", address: "314 E Liberty St, Ann Arbor, MI 48104", picture: UIImage(named:"jerusalem.png")),
            Restaurant(name: "Pizza House", address: "618 Church St, Ann Arbor, MI 48104", picture: UIImage(named:"pizzahouse.png")),
            Restaurant(name: "Starbucks", address: "222 S State St, Ann Arbor, MI 48104", picture: UIImage(named:"starbucks.png")),
            Restaurant(name: "Zingerman's Roadhouse", address: "2501 Jackson Ave, Ann Arbor, MI 48103", picture: UIImage(named:"zingermans.png"))
        ]
    }
}
