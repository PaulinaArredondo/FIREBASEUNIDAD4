//
//  ClassOneCrud.swift
//  Test2
//
//  Created by Daniel Vázquez on 5/5/19.
//  Copyright © 2019 Grupo Maneo. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class oneCrudClass: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nameFieldOne: UITextField!
    @IBOutlet weak var clasificationFieldOne: UITextField!
    @IBOutlet weak var usesFieldOne: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var postDataRef = [String]()
    var databaseHandle: DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Set firebase reference
        ref = Database.database().reference()
        // Retrieve the data and listen for changes
        databaseHandle = ref.child("CrudPrincipal").observe(.childAdded, with:  { (DataSnapshot) in
            let crudOne = DataSnapshot.value as? String
            if let actualInfo = crudOne {
                self.postDataRef.append(actualInfo)
                self.tableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "PostCell")
        cell.textLabel?.text = postDataRef[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            postDataRef.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    @IBAction func posData(_ sender: Any) {
        ref = Database.database().reference()
        if nameFieldOne.text != "" && clasificationFieldOne.text != "" && usesFieldOne.text != "" {
            self.ref?.child("CrudPrincipal").childByAutoId().setValue(["Name": nameFieldOne.text, "Clasification": clasificationFieldOne.text, "Uses": usesFieldOne.text])
            nameFieldOne.text = ""
            clasificationFieldOne.text = ""
            usesFieldOne.text = ""
        } else {
            print("Missing fields")
        }
    }
}
