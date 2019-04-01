//
//  CustomizationData.swift
//  LetUs
//
//  Created by Sean Lu on 3/25/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import Foundation

final class CustomizationData {
    
    static func generateCustomizationData(restaurant: Int, menu: Int) -> [[CustomizationItem]] {
        // Jerusalem Garden
        if (restaurant == 1) {
            if (menu == 0) {
                return [
                    [CustomizationItem(name:"Medium", price: "+$0.00"),
                     CustomizationItem(name:"Large", price: "+$1.00")],
                    [CustomizationItem(name:"Pepperoni", price: "+$1.25"),
                     CustomizationItem(name:"Sausage", price: "+$1.50"),
                    CustomizationItem(name:"Bacon", price: "+$1.75")]
                ]
            }
        }
        return [[]]
    }
    
    static func generateSectionData(restaurant: Int, menu: Int) -> [SectionItem] {
        // Jerusalem Garden
        if (restaurant == 1) {
            if (menu == 0) {
                return [SectionItem(section:"Size", limit:1),
                        SectionItem(section:"Toppings", limit:3)]
            }
        }
        return []
    }
}
