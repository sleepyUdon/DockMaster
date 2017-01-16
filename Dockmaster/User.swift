//
//  User.swift
//  Dockmaster
//
//  Created by Viviane Chan on 2017-01-15.
//  Copyright © 2017 VivianeChan. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
    let company: String
    let firstName: String
    let lastName: String
    let password: String
    let phoneNumber: String

//    
//    init(authData: FIRUser) {
//        email = authData.email!
//    }
    
    init(email: String, company: String, firstName: String, lastName: String, password: String, phoneNumber: String) {
        self.email = email
        self.company = company
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.phoneNumber = phoneNumber
    }

}

