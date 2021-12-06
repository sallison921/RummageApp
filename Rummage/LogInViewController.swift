//
//  RegisterViewController.swift
//  Rummage
//
//  Created by Sydney A on 12/5/21.
//

import UIKit
import Firebase
class LogInViewController: UIViewController {
   

//login stuff
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var pwSignin: UITextField!
    @IBOutlet weak var emailSignin: UITextField!
    
    @IBOutlet weak var errorFound: UILabel!
    
    var refUserInfo: DatabaseReference!
    var refPostInfo: DatabaseReference!
    var refObservers: [DatabaseHandle] = []
    
    var userInfo: NSDictionary!
    var postInfo: NSDictionary!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        pwSignin.isSecureTextEntry = true
        refUserInfo = Database.database().reference(withPath: "user-info")
        refPostInfo = Database.database().reference(withPath: "post-info")
    }
    

    
    @IBAction func loginClicked(_ sender: Any) {
       logIn()
    }
    
    func logIn(){
        Auth.auth().signIn(withEmail: emailSignin.text ?? "", password: pwSignin.text ?? "") {(user, error) in
            if user != nil {
                print("User Has Sign In")
                
                
                //https://fluffy.es/how-to-transition-from-login-screen-to-tab-bar-controller/ got help with changing root controller (same as app delegate)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "mainTab")
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
            }
            
            
            if error != nil {
                //print(":(",error ?? "")
                print(error.debugDescription)
                self.errorFound.numberOfLines = 3
                self.errorFound.text = "There was an error logging in, try again"
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




