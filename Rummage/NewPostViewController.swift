//
//  NewPostViewController.swift
//  Rummage
//
//  Created by Sydney A on 12/5/21.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var addPic: UIButton!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var ref: DatabaseReference!
    var userRef: DatabaseReference!
    var UID = ""
    var username = ""
    var postName = ""
    var imagePicked: UIImage?
   // var postsArray = [Dictionary<String, String>] ()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }

    func getInfo(){
        ref = Database.database().reference().child("post-info")
        userRef = Database.database().reference().child("user-info")
        let user = Auth.auth().currentUser
        
        if let user = user {
            UID = user.uid
           
            userRef.child(user.uid).observe(.value, with: { snapshot in
                let profile = snapshot.value as? [String: String]
                self.username = profile?["username"] ?? "not here"
            })
        }
    }

    func generateName() {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        postName = "post" + String((0..<7).map{ _ in letters.randomElement()! })
        //random alphanumeric generator found online
    }

    @IBAction func postClicked(_ sender: Any) {
        if imagePicked == nil || postBody.text == ""{
           alert(title: "Post Not Complete.", message: "Please fill in all fields to post.")
            return
        }
        guard let data: Data = imagePicked!.jpegData(compressionQuality: 0.1) else {return}
        generateName()
            
        let imageRef = Storage.storage().reference().child("Posts/\(UID)/\(postName).jpeg")
            
        //uploading data to storage
        imageRef.putData(data, metadata: nil) { (metadata, error) in
        if error != nil {
            print("Error occured. Error is \(String(describing: error))")
                return
            }
        }
        //postsArray.append(["caption": postBody.text, "image": "\(postName).jpeg"])
    
        //add to database, caption and picname
//        ref.child(UID).child(postName).child("Picture").setValue("\(postName).jpeg")
//        ref.child(UID).child(postName).child("Caption").setValue(postBody.text)
//        userRef.child(UID).child("Posts").setValue(postsArray)
        
        /////
        let captionWords = postBody.text
        guard let key = ref.childByAutoId().key else { return }
        let post = ["uid": UID,
                    "author": username,
                    "caption": captionWords,
                    "image": "\(postName).jpeg"]
        let childUpdates = ["/posts/\(key)": post,
                            "/userPosts/\(UID)/\(key)/": post]
        
        ref.updateChildValues(childUpdates)
        //////
         
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func addPicClicked(_ sender: Any) {
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
        imagePicked = image
        postPicture.image = image
        
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
}
