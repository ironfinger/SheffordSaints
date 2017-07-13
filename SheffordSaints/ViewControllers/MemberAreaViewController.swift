//
//  MemberAreaViewController.swift
//  SheffordSaints
//
//  Created by Thomas Houghton on 13/07/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MemberAreaViewController: UIViewController {

    @IBOutlet weak var memberTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memberTitleLabel.text = Auth.auth().currentUser?.email
        print("The member is: \(Auth.auth().currentUser?.email)")
    }
}
