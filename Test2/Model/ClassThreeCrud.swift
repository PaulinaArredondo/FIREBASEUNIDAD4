//
//  CrudThree.swift
//  Test2
//
//  Created by Daniel Vázquez on 5/4/19.
//  Copyright © 2019 Grupo Maneo. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class threeCrudClass: UIInputViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nameThreeCrud: UITextField!
    @IBOutlet weak var typeThreeCrud: UITextField!
    @IBOutlet weak var clasificationThreeCrud: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var postDataReceiveThree = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        databaseHandle = ref?.child("CrudTres").observe(.childAdded, with: { (DataSnapshot) in
            let crudThreeModel = DataSnapshot.value as? String
            if let informationCrudThree = crudThreeModel {
                self.postDataReceiveThree.append(informationCrudThree)
                self.tableView.reloadData()
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataReceiveThree.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "showDataThree")
        cell.textLabel?.text = postDataReceiveThree[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            postDataReceiveThree.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    @IBAction func threeButtonCrud(_ sender: UIButton) {
        ref = Database.database().reference()
        if nameThreeCrud.text != "" && typeThreeCrud.text != "" && clasificationThreeCrud.text != "" {
            self.ref?.child("CrudTres").childByAutoId().setValue(["Name Tree Crud": nameThreeCrud.text, "Type of data": typeThreeCrud.text, "Clasification of": clasificationThreeCrud.text])
            nameThreeCrud.text = ""
            typeThreeCrud.text = ""
            clasificationThreeCrud.text = ""
        } else {
            print("Missing fields")
        }
    }
}
