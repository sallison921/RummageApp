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

    @IBOutlet weak var bio: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var logOut: UIButton!
    //buttons on profile page
    //we can add little icons on top of each and make it look pretty
    @IBOutlet weak var createdRecipes: UIButton!
    @IBOutlet weak var followers: UIButton!
    @IBOutlet weak var yourPosts: UIButton!
    @IBOutlet weak var following: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }
    
    func getInfo() {
        //user needs to reload, it is reading as nil first time
//        let user = Auth.auth().currentUser
//        user?.reload()
//        if let user = user {
//            print("username is \(String(describing: user.displayName))")
//            username.text = user.displayName
//            //add pfp later
//        }
        
        let user = Auth.auth().currentUser
        if let user = user {
            ref = Database.database().reference().child("user-info")
            ref.child(user.uid).observe(.value, with: { snapshot in
                let profile = snapshot.value as? [String: String]
                let name = profile?["username"]
                let biography = profile?["bio"]
                self.username.text = name
                self.bio.text = biography
                })
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


