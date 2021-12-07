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
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("user_info")
        
        //getting information from current user
        ref.child(user!.uid).observeSingleEvent(of: .value, with: {snapshot in
            print(snapshot)
            let profile = snapshot.value as? [String: String]
            let bio = profile?["bio"]
            let user = profile?["username"]

            //text fields has current user and bio in them
            self.changeUser.text = user
            self.changeBio.text = bio
        })
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
    
    //saving overall changes
    //pfp not implemented yet
    @IBAction func saveChanges(_ sender: Any) {
        let profile = ["bio": changeBio.text!,
                    "pfp": "nil",
                    "username" : changeUser.text!] as [String : String]
        ref.child(user!.uid).setValue(profile)
        
        let alert = UIAlertController(title: "Profile Saved", message: "Changes have been saved!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default)
     
        alert.addAction(defaultAction)
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.present(alert, animated: true) {
               // The alert was presented
            }
        }
    }
}
