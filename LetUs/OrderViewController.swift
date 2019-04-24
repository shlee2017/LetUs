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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = tableView.indexPathForSelectedRow {
            let vc = segue.destination as? CustomizationViewController
            vc?.restaurantSource = restaurantSource
            vc?.sourceSection = indexPath.section
            vc?.sourceRow = indexPath.row
            vc?.menuName = menuItems[indexPath.section][indexPath.row].name ?? "Food"
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        /*let isPresenting = presentingViewController is UINavigationController
        
        if isPresenting {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The OrderViewController is not inside a navigation controller.")
        }*/
    }
}

