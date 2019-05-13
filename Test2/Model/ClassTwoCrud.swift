//
//  CrudTwo.swift
//  Test2
//
//  Created by Daniel Vázquez on 5/4/19.
//  Copyright © 2019 Grupo Maneo. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class CrudTwo: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nameFieldTwo: UITextField!
    @IBOutlet weak var reusableFieldTwo: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var postDataReceive = [String]()
    var databaseHandleReference: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        databaseHandleReference = ref.child("CrudDos").observe(.childAdded, with: { (DataSnapshot) in
            let crudTwo = DataSnapshot.value as? String
            if let informationCrudTwo = crudTwo {
                self.postDataReceive.append(informationCrudTwo)
                self.tableView.reloadData()
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataReceive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "showTableCell")
        cell.textLabel?.text = postDataReceive[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            postDataReceive.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    @IBAction func acceptButtonTwo(_ sender: UIButton) {
        ref = Database.database().reference()
        if nameFieldTwo.text != "" && reusableFieldTwo.text != "" {
            self.ref?.child("CrudDos").childByAutoId().setValue(["NameTwo": nameFieldTwo.text, "ReusableValue": reusableFieldTwo.text])
            nameFieldTwo.text = ""
            reusableFieldTwo.text = ""
        } else {
            print("Missing fields")
        }
    }
}
