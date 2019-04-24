//
//  CustomizationViewController.swift
//  LetUs
//
//  Created by Sean Lu on 3/25/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit
import AWSAppSync
import os.log
import AWSMobileClient

class CustomizationViewController: UITableViewController {

    var appSyncClient: AWSAppSyncClient?
    
    var restaurantSource:Int = 0
    var sourceSection:Int = 0
    var sourceRow:Int = 0
    var menuName:String = ""
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
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
    
    //need to add the actually order
    @IBAction func addCart(_ sender: UIButton) {
        //sending order
        let temporaryLocalID = "TEMP-\(UUID().uuidString)"
        let name = AWSMobileClient.sharedInstance().username //name
        let table = "tableA" //where table#
        let type = "Order" //when
        let order = menuName //desc
        
        //adds the event
        let addEventMutation = AddEventMutation(name: name!,
                                                when: type,
                                                where: table,
                                                description: order)
        appSyncClient?.perform(mutation: addEventMutation, optimisticUpdate: { transaction in
            do {
                // Update our normalized local store immediately for a responsive UI.
                try transaction?.update(query: ListEventsQuery()) { (data: inout ListEventsQuery.Data) in
                    let localItem = ListEventsQuery.Data.ListEvent.Item(id: temporaryLocalID,
                                                                        description: type,
                                                                        name: name,
                                                                        when: order,
                                                                        where: table,
                                                                        comments: nil)
                    
                    data.listEvents?.items?.append(localItem)
                }
            } catch {
                print("Error updating the cache with optimistic response: \(error)")
            }
        }) { (result, error) in
            
            guard error == nil else {
                print("Error occurred posting a new item: \(error!.localizedDescription )")
                return
            }
            
            guard let createEventResponse = result?.data?.createEvent else {
                print("Result unexpectedly nil posting a new item")
                return
            }
            
            print("New item returned from server and stored in local cache, server-provided id: \(createEventResponse.id)")
            
            let newItem = ListEventsQuery.Data.ListEvent.Item(
                id: createEventResponse.id,
                description: createEventResponse.description,
                name: createEventResponse.name,
                when: createEventResponse.when,
                where: createEventResponse.where,
                // For simplicity, we're assuming newly-created events have no comments
                comments: nil
            )
            
            // Update the local cache for the "list events" operation
            _ = self.appSyncClient?.store?.withinReadWriteTransaction() { transaction in
                try transaction.update(query: ListEventsQuery()) { (data: inout ListEventsQuery.Data) in
                    guard data.listEvents != nil else {
                        print("Local cache unexpectedly has no results for ListEventsQuery")
                        return
                    }
                    
                    var updatedItems = data.listEvents?.items?.filter({ $0?.id != temporaryLocalID })
                    updatedItems?.append(newItem)
                    
                    // `data` is an inout variable inside a read/write transaction. Setting `items` here will cause the
                    // local cache to be updated
                    data.listEvents?.items = updatedItems
                }
            }
        }
        let confirmController = UIAlertController(title: "Order Sent", message: "Please wait patiently. Your waiter will get your order shortly.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        confirmController.addAction(okAction)
        present(confirmController, animated: true)
        return
    }
    
}
