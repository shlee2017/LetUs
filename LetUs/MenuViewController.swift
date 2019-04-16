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
    var menuItems:[[MenuItem]] = [[]]
    var sectionItems:[String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        menuItems = MenuData.generateMenuData(restaurant: restaurantSource)
        sectionItems = MenuData.generateSectionData(restaurant: restaurantSource)
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionItems.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionItems[section]
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell",
                                                 for: indexPath) as! MenuItemCell
        
        let menuItem = menuItems[indexPath.section][indexPath.row]
        cell.menuItem = menuItem
        return cell
    }
}
