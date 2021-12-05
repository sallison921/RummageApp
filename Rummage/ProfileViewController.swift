//
//  ProfileViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/30/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!


    @IBOutlet weak var logOut: UIButton!
    //buttons on profile page
    //we can add little icons on top of each and make it look pretty
    @IBOutlet weak var createdRecipes: UIButton!
    @IBOutlet weak var followers: UIButton!
    @IBOutlet weak var yourPosts: UIButton!
    @IBOutlet weak var following: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        
        // Do any additional setup after loading the view.
    }
    func getInfo(){
        
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
//          let uid = user.uid
          let email = user.email
         print(email ??  "")
            let userDisplayName = user.displayName
            print(userDisplayName ?? "no")
            username.text = userDisplayName
//          var multiFactorString = "MultiFactor: "
//          for info in user.multiFactor.enrolledFactors {
//            multiFactorString += info.displayName ?? "[DispayName]"
//            multiFactorString += " "
//          }
//            print(multiFactorString)
          // ...
        }
    }

    @IBAction func logOutTapped(_ sender: Any) {
  
            do {
                try Auth.auth().signOut()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let loginNavController = storyboard.instantiateViewController(identifier: "logginginNav")

            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(loginNavController)
            }
            catch {
                print("issues")
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


