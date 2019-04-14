//
//  CustomizationData.swift
//  LetUs
//
//  Created by Sean Lu on 3/25/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import Foundation

final class CustomizationData {
    
    static func generateCustomizationData(restaurant: Int, section: Int, row: Int) -> [[CustomizationItem]] {
        // Panera
        if (restaurant == 1) {
            if (section == 2 && row == 3) {
                return [
                    [CustomizationItem(name:"Half", price: ""),
                     CustomizationItem(name:"Whole", price: "+$2.50")],
                    [CustomizationItem(name:"Honey Wheat", price: ""),
                     CustomizationItem(name:"Whole Grain", price: ""),
                     CustomizationItem(name:"Classic White", price: "")],
                    [CustomizationItem(name:"French Baguette", price: ""),
                     CustomizationItem(name:"Apple", price: ""),
                     CustomizationItem(name:"Summer Fruit Cup", price: "+$1.99"),
                     CustomizationItem(name:"Chips", price: ""),
                     CustomizationItem(name:"Sprouted Whole Grain Roll", price: "")]
                ]
            }
        }
        return []
    }
    
    static func generateSectionData(restaurant: Int, section: Int, row: Int) -> [SectionItem] {
        // Panera
        if (restaurant == 1) {
            if (section == 2 && row == 3) {
                return [
                    SectionItem(section:"Size", limit:1),
                    SectionItem(section:"Bread", limit:1),
                    SectionItem(section:"Side", limit:1)
                ]
            }
        }
        return []
    }
}
