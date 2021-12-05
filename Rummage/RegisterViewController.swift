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

    @IBOutlet weak var errorFound: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        pwRegister.isSecureTextEntry = true

    }
    
    @IBAction func registerClicked(_ sender: Any) {

        Auth.auth().createUser(withEmail: emailRegister.text ?? "", password: pwRegister.text ?? "")  {(user, error) in
            if user != nil {
                print("registered")
                
                self.logIn()
                self.addName()
            }
            if error != nil {
                print(":(",error ?? "")
                self.errorFound.numberOfLines = 3
                self.errorFound.text = "There was an error creating your account, please try again"
            }
        }
   
       
    
        
    }
    

    func addName() {
        if Auth.auth().currentUser != nil {
            let addName = Auth.auth().currentUser?.createProfileChangeRequest()
            addName?.displayName = self.usernameRegister.text ?? "nope"
            print(self.usernameRegister.text)
            addName?.commitChanges { error in
                print(error ?? addName?.displayName)
            }
        } else {
          print("not yet")
        }
       
    }
    
    func logIn(){
        Auth.auth().signIn(withEmail: emailRegister.text ?? "", password: pwRegister.text ?? "") {(user, error) in
            if user != nil {
                print("User Has Sign In")
                
                //cited in loginViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "mainTab")
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
                
            }
            if error != nil {
                print(":(",error ?? "")
            }
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




