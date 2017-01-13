import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!

    
    override func viewDidLoad() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
  override func viewDidAppear(_ animated: Bool) {
    if let user = FIRAuth.auth()?.currentUser {
      self.signedIn(user)
    }
  }

    @IBAction func didTapSignIn(_ sender: AnyObject) {
        //     Sign In with credentials.
        guard let email = emailField.text, let password = passwordField.text else {
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                // VIV: add alert wrong username and password
                let alert = UIAlertController(title: "Alert", message: "Incorrect username or password. Try Again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "LoginToTabBar", sender: nil)
            }
        }
    }
    
  @IBAction func didTapSignUp(_ sender: AnyObject) {
    performSegue(withIdentifier: "LoginToSignup", sender: nil)
  }

  @IBAction func didRequestPasswordReset(_ sender: AnyObject) {
    let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: .alert)
    let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
      let userInput = prompt.textFields![0].text
      if (userInput!.isEmpty) {
        return
      }
      FIRAuth.auth()?.sendPasswordReset(withEmail: userInput!) { (error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }
      }
    }
    prompt.addTextField(configurationHandler: nil)
    prompt.addAction(okAction)
    present(prompt, animated: true, completion: nil);
  }

  func signedIn(_ user: FIRUser?) {
    AppState.sharedInstance.displayName = user?.displayName ?? user?.email
    AppState.sharedInstance.signedIn = true
    let notificationName = Notification.Name(rawValue: "userSignedIn")
    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
    performSegue(withIdentifier: "LoginToTabBar", sender: nil)
  }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        return true
    }
}
