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
        
        customizations = CustomizationData.generateCustomizationData(restaurant: restaurantSource, section: sourceSection, row: sourceRow)
        sectionItems = CustomizationData.generateSectionData(restaurant: restaurantSource, section: sourceSection, row: sourceRow)
        selectedItems = Array(repeating:[CustomizationItem](), count:sectionItems.count)
        
        tableView.tableFooterView = UIView()
        
        // Lower keyboard when tapping elsewhere
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    // Returns number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionItems.count + 1
    }
    
    // Returns number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section < customizations.count) {
            return customizations[section].count
        }
        else {
            return 2;
        }
    }
    
    // Returns title for each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section < customizations.count) {
            return sectionItems[section].section
        }
        else {
            return "Special Instructions"
        }
    }
    
    // What to display in cell
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section < customizations.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomizationCell",
                                                     for: indexPath) as! CustomizationCell
            
            let item = customizations[indexPath.section][indexPath.row]
            cell.customization = item
            return cell
        }
        else {
            if (indexPath.row == 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell",
                                                         for: indexPath) as! NotesCell
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell",
                                                         for: indexPath) as UITableViewCell
                return cell
            }
        }
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
            sender.isChecked = false
        }
        // Add item if in selectedItems list
        else {
            // Only add item if less than limit for section
            if selectedItems[cellSection].count < sectionItems[cellSection].limit {
                selectedItems[cellSection].append(item)
                sender.isChecked = true
            }
        }
    }
}
