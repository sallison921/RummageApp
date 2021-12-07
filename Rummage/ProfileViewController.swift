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
    var pfpName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        profilePicture()
    }
    
    func getInfo() {
        let user = Auth.auth().currentUser
        if let user = user {
            ref = Database.database().reference().child("user-info")
            ref.child(user.uid).observe(.value, with: { snapshot in
                let profile = snapshot.value as? [String: String]
                let name = profile?["username"]
                let biography = profile?["bio"]
                let pfp = profile?["pfp"]
                
                self.username.text = name
                self.bio.text = biography
                self.pfpName = pfp ?? "no_profile.png"
            })
        }
    }
    
    //getting photo from the database
    func profilePicture() {
        let newRef = Storage.storage().reference(forURL: "gs://rummage-e3626.appspot.com/Profiles/" + pfpName)
   
        newRef.getData(maxSize: 1*1024*1024, completion: { (data, error) in
            if let error = error {
                print("Error occurred \(String(describing: error))")
            } else {
                let image = UIImage(data: data!)
                self.profilePic.image = image
            }
        })
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
