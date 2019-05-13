//
//  CrudThree.swift
//  Test2
//
//  Created by Daniel Vázquez on 5/4/19.
//  Copyright © 2019 Grupo Maneo. All rights reserved.
//

import Foundation
import Firebase

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class CrudThree {
    let nameThree: String
    let typeThree: String
    let clasificationThree: String
    
    init(nameThree: String, typeThree: String, clasificationThree: String) {
        self.nameThree = nameThree
        self.typeThree = typeThree
        self.clasificationThree = clasificationThree
    }
}
