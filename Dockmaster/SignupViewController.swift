//
//  SignupVC.swift
//  Dockmaster
//
//  Created by Viviane Chan on 2017-01-12.
//  Copyright © 2017 VivianeChan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    
    
    override func viewDidLoad() {
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.companyField.delegate = self
        self.emailField.delegate = self
        self.passwordField.delegate = self

    }
    
    
    @IBAction func didTapSignUp(_ sender: AnyObject) {
        guard let firstName = firstNameField.text, let lastName = lastNameField.text, let company = companyField.text, let phoneNumber = phoneNumberField.text,let email = emailField.text, let password = passwordField.text else {
            _ = UIAlertController.init(title: nil, message: "Missing fields. Try again.", preferredStyle: .alert)
            return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
//            self.setDisplayName(user!)
            self.performSegue(withIdentifier: "SignupToLogin", sender: nil)
        }
    }
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.firstNameField.resignFirstResponder()
        self.lastNameField.resignFirstResponder()
        self.companyField.resignFirstResponder()
        self.phoneNumberField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()

        return true
    }

//    func setDisplayName(_ user: FIRUser) {
//        let changeRequest = user.profileChangeRequest()
//        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
//        changeRequest.commitChanges(){ (error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//    }
//
}
