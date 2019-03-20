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
    @IBOutlet weak var phoneNumberTextField: UITextField!
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
        phoneNumberTextField.isEnabled = false
        emailTextField.isEnabled = false
        
        usernameTextField.text = AWSMobileClient.sharedInstance().username
        //phoneNumberTextField.text =
    }
    
    
    //test stuff
    func runMutation(){
        let mutationInput = CreateTodoInput(name: "Use AppSync", description:"Realtime and Offline")
        appSyncClient?.perform(mutation: CreateTodoMutation(input: mutationInput)) { (result, error) in
            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
            }
            if let resultError = result?.errors {
                print("Error saving the item on server: \(resultError)")
                return
            }
        }
    }
    func runQuery(){
        appSyncClient?.fetch(query: ListTodosQuery(), cachePolicy: .returnCacheDataAndFetch) {(result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            result?.data?.listTodos?.items!.forEach { print(($0?.name)! + " " + ($0?.description)!) }
        }
    }
    var discard: Cancellable?
    
    func subscribe() {
        do {
            discard = try appSyncClient?.subscribe(subscription: OnCreateTodoSubscription(), resultHandler: { (result, transaction, error) in
                if let result = result {
                    print(result.data!.onCreateTodo!.name + " " + result.data!.onCreateTodo!.description!)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            })
        } catch {
            print("Error starting subscription.")
        }
    }
}
