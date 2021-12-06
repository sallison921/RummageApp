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
    @IBOutlet weak var biographyRegister: UITextField!
    
    @IBOutlet weak var errorFound: UILabel!
    
    //these allow for us to save/sync data to db
    var refUserInfo: DatabaseReference!
    var refPostInfo: DatabaseReference!
    var refObservers: [DatabaseHandle] = []
    
    var userInfo: NSDictionary!
    var postInfo: NSDictionary!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        pwRegister.isSecureTextEntry = true
        refUserInfo = Database.database().reference(withPath: "user-info")
        refPostInfo = Database.database().reference(withPath: "post-info")

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        self.logIn()
        self.addName()
        
//        Auth.auth().createUser(withEmail: emailRegister.text ?? "", password: pwRegister.text ?? "")  {(user, error) in
//            if user != nil {
//                print("registered")
//
//                self.logIn()
//                self.addName()
//            }
//            if error != nil {
//                print(":(",error ?? "")
//                self.errorFound.numberOfLines = 3
//                self.errorFound.text = "There was an error creating your account, please try again"
//            }
//        }
   
       
    
        
    }
    

    func addName() {
        let registerEmail = emailRegister.text ?? ""
        let newUserRef = refUserInfo.child(registerEmail.lowercased())
        //^^makes sure database saves only latest entry of the username (whether its all lower or all upper or mixed cased)
        userInfo = ["email": emailRegister.text ?? "testUser", "password": pwRegister.text ?? "password", "bio": biographyRegister.text ?? "-"]
        newUserRef.setValue(userInfo)
//        if Auth.auth().currentUser != nil {
//            let addName = Auth.auth().currentUser?.createProfileChangeRequest()
//            addName?.displayName = self.usernameRegister.text ?? "nope"
//            print(self.usernameRegister.text)
//            addName?.commitChanges { error in
//                print(error ?? addName?.displayName)
//            }
//        } else {
//          print("not yet")
//        }
       
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




