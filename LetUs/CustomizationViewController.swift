//
//  CustomizationViewController.swift
//  LetUs
//
//  Created by Sean Lu on 3/25/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class CustomizationViewController: UITableViewController {

    var restaurantSource:Int = 0
    var menuSource:Int = 0
    var customizations:[[CustomizationItem]] = [[]]
    var sectionItems:[SectionItem] = []
    var selectedItems:[[CustomizationItem]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        customizations = CustomizationData.generateCustomizationData(restaurant: restaurantSource, menu: menuSource)
        sectionItems = CustomizationData.generateSectionData(restaurant: restaurantSource, menu: menuSource)
        selectedItems = Array(repeating:[CustomizationItem](), count:sectionItems.count)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionItems.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customizations[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionItems[section].section
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomizationCell",
                                                 for: indexPath) as! CustomizationCell
        
        let cust = customizations[indexPath.section][indexPath.row]
        cell.customization = cust
        
        return cell
    }
}
