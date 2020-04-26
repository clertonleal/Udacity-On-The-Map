//
//  LoginViewController.swift
//  Map
//
//  Created by Clêrton Cunha Leal on 26/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private let signupUrl = "https://auth.udacity.com/sign-up"
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        print("Email: \(String(describing: textEmail.text))")
        print("Password: \(String(describing: textPassword.text))")
        performSegue(withIdentifier: "goToMap", sender: nil)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if let url = URL(string: signupUrl) {
            UIApplication.shared.open(url)
        }
    }
}
