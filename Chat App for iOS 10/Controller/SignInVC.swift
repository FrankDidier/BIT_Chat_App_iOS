//
//  SignInVC.swift
//  Chat App for iOS 10
//
//  Created by apple on 6/7/18.
//  Copyright © 2018 Frank Nerdy. All rights reserved.
//

import UIKit


class SignInVC: UIViewController {
    
    private let CONTACTS_SEGUE = "ContactsSegue";

    @IBOutlet weak var emailTextfield: UITextField!
    
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {
        if AuthProvider.Instance.isLoggedIn() {
            performSegue(withIdentifier: self.CONTACTS_SEGUE, sender: nil);
        }
    }
    
    @IBAction func login(_ sender: Any) {
        //performSegue(withIdentifier: CONTACTS_SEGUE, sender: nil);
        
        if emailTextfield.text != "" && passwordTextfield.text != "" {
            AuthProvider.Instance.login(withEmail: emailTextfield.text!, password: passwordTextfield.text!, loginHandler: {(message) in
                
                if message != nil {
                    self.alertTheUser(title: "Problem with Authentication", message: message!);
                    //self.alertTheUser(title: "Email And Password Are Required", message: "Please enter your Email and password correctly in the text fields");
                }else{
                    self.emailTextfield.text = "";
                    self.passwordTextfield.text = "";
                    
                    self.performSegue(withIdentifier: self.CONTACTS_SEGUE, sender: nil);
                    print("LOGIN COMPLETED");
                }
            })
            }
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if emailTextfield.text != "" && passwordTextfield.text != "" {
            
            AuthProvider.Instance.signUp(withEmail: emailTextfield.text!, password: passwordTextfield.text!, loginHandler: {(message) in
                if message != nil {
                    self.alertTheUser(title: "Problem With Creating A New User", message: message!);
                }else {
                    
                    print("CREATING USER COMPLETED");

                }
            })
            
        }else{
            self.alertTheUser(title: "Email And Password Are Required", message: "Please enter your Email and password correctly in the text fields");
        }
        
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
        
        
    }
} // class

























