//
//  SettingsViewController.swift
//  LetUs
//
//  Created by Sean Lu on 3/17/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit
import AWSAppSync
import AWSMobileClient

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    var appSyncClient: AWSAppSyncClient?
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var logOutButton: UIButton?
    
    @IBAction func signOutButtonTapped(_ sender: Any){
        AWSMobileClient.sharedInstance().signOut()
        AWSMobileClient.sharedInstance()
            .showSignIn(navigationController: self.navigationController!,
                        signInUIOptions: SignInUIOptions(
                            canCancel: false,
                            logoImage: UIImage(named: "AppIcon"),
                            backgroundColor: UIColor.white)) { (result, err) in
        }
        print("Sign out button tapped")
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //app sync stuff
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient

        
        usernameTextField.isEnabled = false
        nameTextField.isEnabled = false
        emailTextField.isEnabled = false
        
        if ( AWSMobileClient.sharedInstance().isSignedIn ){
            usernameTextField.text = AWSMobileClient.sharedInstance().username
        }
    }
}
