//
//  MenuData.swift
//  LetUs
//
//  Created by Sean Lu on 3/14/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import Foundation

final class MenuData {
    
    static func generateMenuData(restaurant: Int) -> [MenuItem] {
        if (restaurant == 0) {
            return [
                MenuItem(name: "Burrito", description: "Tortilla, chicken, rice, beans, salsa", price: "$6.50"),
                MenuItem(name: "Burrito Bowl", description: "Steak, beans, rice, guacomole in a bowl", price: "$6.50"),
                MenuItem(name: "Taco", description: "Hard shell, carnitas, rice, pico de gallo", price: "$3.00"),
                MenuItem(name: "Salad", description: "Lettuce, tomatoes, blackberries, ranch dressing", price: "$5.00")
            ]
        }
        else if (restaurant == 1) {
            return [
                MenuItem(name: "Falafel Plate", description: "Three paties, ground chickpeas, parsley, onions, jalapenos", price: "$8.50"),
                MenuItem(name: "Chicken Shawarma Plate", description: "Seasoned chicekn breast with yogurt garlic sauce", price: "$12.50"),
                MenuItem(name: "Beef Shish Kabob Plate", description: "Grilled marinated beef with red onions", price: "$14.50")
            ]
        }
        else if (restaurant == 2) {
            return [
                MenuItem(name: "Palazzo Special", description: "Pepperoni, salami, sausage, mushroom", price: "$15.60"),
                MenuItem(name: "Mediterranean Special", description: "Mushrooms, onions, bell peppers, sliced tomatoes, olives", price: "$18.25"),
                MenuItem(name: "Fiesta Special", description: "Ground beef, onions, jalapenos, mushrooms", price: "$16.90")
            ]
        }
        else if (restaurant == 3) {
            return [
                MenuItem(name: "Iced Caramel Macchiato", description: "Basic white girl drink", price: "$3.95"),
                MenuItem(name: "Frappuccino", description: "Slightly less basic", price: "$4.95"),
                MenuItem(name: "Black Coffee", description: "For the real coffee lovers", price: "$3.00")
            ]
        }
        else {
            return [
                MenuItem(name: "New York Strip", description: "10 ounces, boneless", price: "$36.00"),
                MenuItem(name: "Ribeye and Caesar Salad", description: "Grilled, marinated 10oz. boneless ribeye over romaine lettuce", price: "$34.00"),
                MenuItem(name: "Texas BBQ Plate", description: "10 hours smoked Tellichery Texas brisket", price: "$30.00")
            ]
        }
    }
}
