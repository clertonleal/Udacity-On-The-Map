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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "goToMap", sender: nil)
//        if let email = textEmail.text, let password = textPassword.text {
//            UdacityNetwork().doLogin(email: email, password: password, success: { success in
//                self.performSegue(withIdentifier: "goToMap", sender: nil)
//            }, errorCallback: { error in
//                let alert = UIAlertController(title: "Error", message: error.error, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//                self.present(alert, animated: true)
//            })
//        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if let url = URL(string: signupUrl) {
            UIApplication.shared.open(url)
        }
    }
}
