//
//  SettingsViewController.swift
//  LetUs
//
//  Created by Sean Lu on 3/17/19.
//  Copyright © 2019 Ethan Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        
        // Set text fields to stored values
        nameTextField.text = defaults.string(forKey: "name")
        passwordTextField.text = defaults.string(forKey: "password")
        emailTextField.text = defaults.string(forKey: "email")
        
        // Lower keyboard when tapping elsewhere
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Store text fields when finished editing
        defaults.set(nameTextField.text, forKey: "name")
        defaults.set(passwordTextField.text, forKey: "password")
        defaults.set(emailTextField.text, forKey: "email")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Lower keyboard when tapping return
        self.view.endEditing(true)
        return false
    }
}
