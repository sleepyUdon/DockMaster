//
//  ProjectsViewController.swift
//  Dockmaster
//
//  Created by Viviane Chan on 2017-01-13.
//  Copyright © 2017 VivianeChan. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth

class ProjectsViewController: UIViewController {
    
    
    @IBAction func handleSignOutButton(_ sender: UIButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            AppState.sharedInstance.signedIn = false
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }

    }
    
}
