//
//  OrderViewController.swift
//  LetUs
//
//  Created by Sangheon Lee on 3/21/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import Foundation
import UIKit
import os.log

class OrderViewController: UITableViewController{

    // MARK: - Properties
    var restaurantSource = 0
    var menuItems:[MenuItem] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        menuItems = MenuData.generateMenuData(restaurant: restaurantSource)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //causing error
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuItemCell
        
        let menuItem = menuItems[indexPath.row]
        cell.menuItem = menuItem
        return cell
    }
}

