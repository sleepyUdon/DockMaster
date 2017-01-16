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
import Firebase
import FirebaseStorage
import FirebaseDatabase



class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var storageRef: FIRStorageReference!
    var projects: [Project] = []
    fileprivate var _refHandle: FIRDatabaseHandle!
    var email: String = ""
    let ref = FIRDatabase.database().reference(withPath: "projects")

    
    override func viewDidLoad() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "projectsCell")
        getUser()
        configureDatabase()
        configureStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func getUser(){
        let user = FIRAuth.auth()?.currentUser
        let rawEmail = user?.email
        self.email = (rawEmail?.replacingOccurrences(of: ".", with: ""))!
    }
    
    
    func configureDatabase() {
        ref.queryOrdered(byChild: "projects").observe(.value, with: { snapshot in
            var newProjects: [Project] = []
            
            for item in snapshot.children {
                let project = Project(snapshot: item as! FIRDataSnapshot)
                newProjects.append(project)
            }
            
            self.projects = newProjects
            self.tableView.reloadData()
        })

    }
    
    func configureStorage()   {
        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.tableView .dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectsTableViewCell
        
        let project = projects[indexPath.row]
        cell.titleLabel.text = project.projectName
//        cell.projectImageView = project.projectPhotoURL

        return cell
    }

    
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
