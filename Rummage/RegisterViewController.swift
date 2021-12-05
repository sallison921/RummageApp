//
//  RegisterViewController.swift
//  Rummage
//
//  Created by Sydney A on 12/5/21.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
   
    //register stuff
    @IBOutlet weak var usernameRegister: UITextField!
    @IBOutlet weak var pwRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var nameTextRegister: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
//login stuff
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var pwSignin: UITextField!
    @IBOutlet weak var emailSignin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailRegister.text ?? "", password: pwRegister.text ?? "") { authResult, error in
            print(authResult?.additionalUserInfo)
            print("hi")
            
        }
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://www.example.com") //what is our url
        // The sign-in operation has to always be completed in the app.
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
   
        Auth.auth().sendSignInLink(toEmail: emailRegister.text ?? "", actionCodeSettings: actionCodeSettings){error in
            
            if let error = error {
                  //self.showMessagePrompt(error.localizedDescription)
                  return
                    
                }
                // The link was successfully sent. Inform the user.
                // Save the email locally so you don't need to ask the user for it again
                // if they open the link on the same device.
               // UserDefaults.standard.set(email, forKey: "Email")
               // self.showMessagePrompt("Check your email for link")
                // ...
        }
      
        
    }
   // https://github.com/firebase/quickstart-ios/blob/6c420f893cea50d319931451d9fe110c534f9fcf/authentication/LegacyAuthQuickstart/AuthenticationExampleSwift/PasswordlessViewController.swift#L65-L71 
    
    @IBAction func loginClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailSignin.text ?? "", password: pwSignin.text ?? "") { [weak self] authResult, error in
            guard self != nil else { return }
          // ...
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
