//
//  MembersSignInViewController.swift
//  SheffordSaints
//
//  Created by Thomas Houghton on 13/07/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MembersSignInViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signOutPossibleMember() // This is to make sure that a member isn't signed in when they leave their area.
    }
    
    func signOutPossibleMember() {
        do {
            try Auth.auth().signOut()
        } catch  {
            print("A user wasn't signed in in the first place.")
        }
    }
    
    @IBAction func SignInTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in // This completion tries to sign in the user.
            print("We tried to sign in!")
            if error != nil { // If there is an error create a new user.
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in // This creates a new user.
                    print("We created a user.")
                    if error != nil {
                        print("We have a serious error \(error)")
                    }else{
                        print("The user is actually created")
                        print("Here is the user's UID: \(Auth.auth().currentUser?.uid)")
                        let users = Database.database().reference().child("Users").child(user!.uid).child("email").setValue(user!.email)
                        self.performSegue(withIdentifier: "memberAreaSegue", sender: nil)
                    }
                })
            }else{
                print("We signed in.")
                print("Here is the user's UID: \(Auth.auth().currentUser?.uid)")
                self.performSegue(withIdentifier: "memberAreaSegue", sender: nil)
            }
        }
    }
    
}
