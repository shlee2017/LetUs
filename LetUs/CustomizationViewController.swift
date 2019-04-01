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
    var sourceSection:Int = 0
    var sourceRow:Int = 0
    var customizations:[[CustomizationItem]] = [[]]
    var sectionItems:[SectionItem] = []
    var selectedItems:[[CustomizationItem]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        customizations = CustomizationData.generateCustomizationData(restaurant: restaurantSource, section: sourceSection, row: sourceRow)
        sectionItems = CustomizationData.generateSectionData(restaurant: restaurantSource, section: sourceSection, row: sourceRow)
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
        
        let item = customizations[indexPath.section][indexPath.row]
        cell.customization = item
        
        return cell
    }
    
    // Action for pressing button
    @IBAction func buttonPressed(_ sender: CheckBox) {
        let touchPoint = sender.convert(CGPoint.zero, to: self.tableView)
        var clickedButtonIndexPath = self.tableView.indexPathForRow(at: touchPoint)
        
        let cellSection = clickedButtonIndexPath!.section // pressed section
        let cellRow = clickedButtonIndexPath!.row // pressed row
        let item = customizations[cellSection][cellRow] // pressed item
        
        // Remove item if in selectedItems list
        if let i = selectedItems[cellSection].firstIndex(where:{$0.name == item.name}) {
            selectedItems[cellSection].remove(at: i)
        }
        // Add item if in selectedItems list
        else {
            // Only add item if less than limit for section
            if selectedItems[cellSection].count < sectionItems[cellSection].limit {
                selectedItems[cellSection].append(item)
            }
            else {
                sender.isChecked = true
            }
        }
        
    }
}
