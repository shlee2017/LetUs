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
        // Pizza House
        if (restaurant == 2) {
            if (section == 0 && row == 3) {
                return [
                    [CustomizationItem(name:"Half (4)", price: ""),
                     CustomizationItem(name:"Full (8)", price: "+$5.00"),
                     CustomizationItem(name:"Double (16)", price: "+$8.00"),
                     CustomizationItem(name:"Family (21)", price: "+$15.00")],
                    [CustomizationItem(name:"Ranch", price: ""),
                     CustomizationItem(name:"Bleu cheese", price: "")]
                ]
            }
        }
        return [[]]
    }
    
    static func generateSectionData(restaurant: Int, section: Int, row: Int) -> [SectionItem] {
        // Pizza House
        if (restaurant == 2) {
            if (section == 0 && row == 3) {
                return [
                    SectionItem(section:"Size", limit:1),
                    SectionItem(section:"Sauce", limit:1)
                ]
            }
        }
        return []
    }
}
