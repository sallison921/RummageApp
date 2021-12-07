//
//  EditProfileViewController.swift
//  Rummage
//
//  Created by Michelle Zhou on 12/5/21.
//

import UIKit
import Photos
import Firebase

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pfp: UIImageView!
    @IBOutlet weak var changeUser: UITextField!
    @IBOutlet weak var changeBio: UITextField!
    var ref: DatabaseReference!
    var UID = ""
    var currentUsername = ""
    var currentBio = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }
    
    func getInfo(){
        let user = Auth.auth().currentUser
        
        if let user = user {
            UID = user.uid
            ref = Database.database().reference().child("user-info")

            ref.child(UID).observeSingleEvent(of: .value, with: {snapshot in
                let profile = snapshot.value as? [String: String]
                let username = profile?["username"]
                let bio = profile?["bio"]

                self.currentBio = bio ?? "Bio"
                self.changeBio.text = bio
                
                self.currentUsername = username ?? "Username"
                self.changeUser.text = username
            })
        }
    }
    
    //stuff for profile picture
    @IBAction func changePic(_ sender: Any) {
        let ac = UIAlertController(title: "Select Image From", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in self.getPhoto(fromSourceType: .camera)})) //
        ac.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in self.getPhoto(fromSourceType: .photoLibrary)}))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func getPhoto(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self;
                imagePickerController.sourceType = sourceType
            //tried to add requesting authorization
//                var authorized = false
//            PHPhotoLibrary.requestAuthorization({
//                (status) in
//                if status == PHAuthorizationStatus.authorized {
//                    authorized = true
//                }
//            })
//            if authorized {
//                self.present(imagePickerController, animated: true, completion: nil)
//            }
            self.present(imagePickerController, animated: true, completion: nil)
           
               
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            print("Could not get image")
            return
        }
            pfp.image = image
            self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default)
     
        alert.addAction(defaultAction)
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.present(alert, animated: true) {
               // The alert was presented
            }
        }
    }

    //saving overall changes
    //pfp not implemented yet
    @IBAction func saveChanges(_ sender: Any) {
        //bc "" does not get read as nil, can't have an empty username or bio
        if changeUser.text == "" || changeBio.text == ""{
            alert(title: "Empty Text Field", message: "Text fields cannot be left empty. Please add input.")
            return
        }
        
        //updating user profile
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = changeUser.text ?? currentUsername
        changeRequest?.commitChanges { error in
          print("Error is: \(String(describing: error))")
        }

        //sending changed information to the database
        let profile = ["bio": changeBio.text ?? currentBio,
                    "pfp": "no_profile.png",
                    "username" : changeRequest?.displayName] as? [String : String]
        ref.child(UID).setValue(profile)
        
        //alert that changes have been saved
        alert(title: "Profile Saved", message: "Changes have been saved!")
    }
}
