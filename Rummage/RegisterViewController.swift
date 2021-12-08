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
    var ref: DatabaseReference!
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
        Auth.auth().createUser(withEmail: emailRegister.text ?? "", password: pwRegister.text ?? "")  {(user, error) in
            if user != nil {
                print("registered")
                
                self.logIn()
                self.addInfo()
            }
            if error != nil {
                print(":(",error ?? "")
                self.errorFound.numberOfLines = 3
                self.errorFound.text = "There was an error creating your account, please try again"
            }
        }
    }
    

    func addInfo() {
        let user = Auth.auth().currentUser
        if user != nil {
     
          
            let generatedUsername: String = user!.uid
            let username = usernameRegister.text ?? generatedUsername
            let emptyFollowers = [String]()
            let emptyFollowing = [String]()
            let addInfo = Auth.auth().currentUser?.createProfileChangeRequest()
            addInfo?.displayName = username
           
            print(usernameRegister.text!)
            addInfo?.commitChanges { error in
                print(error ?? addInfo?.displayName as Any)
  
                self.refUserInfo.child(user!.uid).child("username").setValue(username)
                self.refUserInfo.child(user!.uid).child("bio").setValue(self.biographyRegister.text ?? "Hi there!")
                self.refUserInfo.child(user!.uid).child("pfp").setValue("no_profile.png")
                self.refUserInfo.child(user!.uid).child("followedBy").setValue(emptyFollowers)
                self.refUserInfo.child(user!.uid).child("following").setValue(emptyFollowing)
            }

           
        } else {
          print("not yet")
        }
      
    }
    
    func logIn(){
        Auth.auth().signIn(withEmail: emailRegister.text ?? "", password: pwRegister.text ?? "") {(user, error) in
            if user != nil {
                print("User Has Signed In")
                
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





