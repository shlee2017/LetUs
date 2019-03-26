//
//  CustomizationData.swift
//  LetUs
//
//  Created by Sean Lu on 3/25/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import Foundation

final class CustomizationData {
    
    static func generateCustomizationData(restaurant: Int, menu: Int) -> [[String]] {
        // Jerusalem Garden
        if (restaurant == 1) {
            if (menu == 0) {
                return [
                    ["Medium", "Large"],
                    ["Pepperoni", "Sausage", "Bacon"]
                ]
            }
        }
        return [[]]
    }
    
    static func generateSectionData(restaurant: Int, menu: Int) -> [CustItem] {
        // Jerusalem Garden
        if (restaurant == 1) {
            if (menu == 0) {
                return [CustItem(section:"Size", isCheck:true),
                        CustItem(section:"Toppings", isCheck:false)]
            }
        }
        return []
    }
}
