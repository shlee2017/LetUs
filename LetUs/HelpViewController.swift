//
//  HelpViewController.swift
//  LetUs
//
//  Created by Sangheon Lee on 4/7/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import Foundation
import UIKit
import os.log
import AWSMobileClient
import AWSAppSync

class HelpViewController: UITableViewController{
    
    // MARK: - Properties
    var helpOption:[String] = ["Water refill", "Extra Spoon", "Extra Knife", "Extra Fork", "Extra Plate"]
    var numHelp = 0;
    var appSyncClient: AWSAppSyncClient?
    var event: Event?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        // Initialize AWSMobileClient for authorization
        AWSMobileClient.sharedInstance().initialize { (userState, error) in
            guard error == nil else {
                print("Failed to initialize AWSMobileClient. Error: \(error!.localizedDescription)")
                return
            }
            print("AWSMobileClient initialized.")
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpOption.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HelpViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HelpViewCell else {
            fatalError("The dequeued cell is not an instance of HelpViewCell.")
        }
        cell.setHelp(help: helpOption[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            numHelp-=1;
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            numHelp+=1;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func requestButton(_ sender: UIBarButtonItem) {
        if (numHelp<=0) {
            let alertController = UIAlertController(title: "Error", message: "Please select a help option.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
            
            return
        }
        
        let temporaryLocalID = "TEMP-\(UUID().uuidString)"
        let name = AWSMobileClient.sharedInstance().username //name
        let table = "tableA" //where username+table#
        let type = "Help" //when
        var order = "" //desc
        for i in 0..<helpOption.count {
            let index = IndexPath(row: i, section: 0)
            if(self.tableView.cellForRow(at: index)?.accessoryType == UITableViewCell.AccessoryType.checkmark){
                let comment = helpOption[i]
                order += comment + "\\n"
                print(order)
            }
        }
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
        let confirmController = UIAlertController(title: "Help Sent", message: "Please wait patiently. Your waiter will help you shortly.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        confirmController.addAction(okAction)
        present(confirmController, animated: true)
        return
    }
}
