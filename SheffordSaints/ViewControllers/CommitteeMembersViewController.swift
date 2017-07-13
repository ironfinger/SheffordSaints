//
//  CommitteeMembersViewController.swift
//  SheffordSaints
//
//  Created by Thomas Houghton on 13/07/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CommitteeMembersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var members:[Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        Database.database().reference().child("Users").observe(DataEventType.childAdded) { (snapshot) in
            print(snapshot)
            // Get the User email.
            let member = Member()
            let value = snapshot.value as? NSDictionary // Lets the compiler know that the value know that the snapshot values is an NSDictionary.
            let memberEmail = value?["email"] as? String ?? ""
            member.email = memberEmail
            self.members.append(member)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let member = members[indexPath.row]
        cell.textLabel?.text = member.email
        return cell
    }
}
