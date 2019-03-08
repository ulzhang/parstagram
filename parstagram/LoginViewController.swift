//
//  LoginViewController.swift
//  parstagram
//
//  Created by Kevin Zhang on 3/5/19.
//  Copyright © 2019 Kevin Zhang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                // if succeeded perform the segue
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("success sign in")
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        

        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        //  user.email = "email@example.com"
        // other fields can be set just like with PFObject
        //  user["phone"] = "415-392-0202"
        
        user.signUpInBackground { (success, error) in
            
            if success {
                // if succeeded perform the segue
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("success sign up")
            } else {
                print("Error: \(error?.localizedDescription)")
            }
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
