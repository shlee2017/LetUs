//
//  HomeViewController.swift
//  LetUs
//
//  Created by Sean Lu on 2/3/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit
import AWSAppSync
import AWSMobileClient

class Todos: UIViewController{
    //Reference AppSync client
    var appSyncClient: AWSAppSyncClient?
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create AWSMobileClient to connect with AWS
        return AWSMobileClient.sharedInstance().interceptApplication(
            application,
            didFinishLaunchingWithOptions: launchOptions)
        
    }
}

class HomeViewController: UITableViewController {

    // MARK: - Properties
    var restaurants = RestaurantData.generateRestaurantData()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let indexPath = tableView.indexPathForSelectedRow {
            let vc = segue.destination as? MenuViewController
            vc?.restaurantSource = indexPath.row
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell",
                                                 for: indexPath) as! RestaurantCell
        
        let restaurant = restaurants[indexPath.row]
        cell.restaurant = restaurant
        return cell
    }
}
