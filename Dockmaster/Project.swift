//
//  Project.swift
//  Dockmaster
//
//  Created by Viviane Chan on 2017-01-15.
//  Copyright © 2017 VivianeChan. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Project {
    
    let address: String
    let contactNumber: String
    let contactPerson: String
    let map1PhotoURL: String
    let map2PhotoURL: String
    let projectName: String
    let projectPhotoURL: String

    
    let ref: FIRDatabaseReference?
    
    init(address: String, contactNumber: String, contactPerson: String, map1PhotoURL: String, map2PhotoURL: String, projectName: String, projectPhotoURL: String) {
        self.address = address
        self.contactNumber = contactNumber
        self.contactPerson = contactPerson
        self.map1PhotoURL = map1PhotoURL
        self.map2PhotoURL = map2PhotoURL
        self.projectName = projectName
        self.projectPhotoURL = projectPhotoURL
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
//        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        address = snapshotValue["address"] as! String
        contactNumber = snapshotValue["contactNumber"] as! String
        contactPerson = snapshotValue["contactPerson"] as! String
        map1PhotoURL = snapshotValue["map1PhotoURL"] as! String
        map2PhotoURL = snapshotValue["map2PhotoURL"] as! String
        projectName = snapshotValue["projectName"] as! String
        projectPhotoURL = snapshotValue["projectPhotoURL"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "address":address,
            "contactNumber": contactNumber,
            "contactPerson": contactPerson,
            "projectName": projectName,
            "map1PhotoURL": map1PhotoURL,
            "projectPhotoURL": projectPhotoURL
        ]
    }
    
}
