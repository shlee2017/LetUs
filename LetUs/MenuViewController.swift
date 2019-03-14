//
//  MenuViewController.swift
//  LetUs
//
//  Created by Sean Lu on 3/14/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    // MARK: - Properties
    var restaurantSource:Int = 0
    var menuItems:[MenuItem] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menuItems = MenuData.generateMenuData(restaurant: restaurantSource)
    }

}

// MARK: - UITableViewDataSource
extension MenuViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell",
                                                 for: indexPath) as! MenuItemCell
        
        let menuItem = menuItems[indexPath.row]
        cell.menuItem = menuItem
        return cell
    }
}
