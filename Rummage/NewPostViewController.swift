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
    var UID = ""
    var picName = ""
    var imagePicked: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        // Do any additional setup after loading the view.
    }
    
    func getInfo(){
        let user = Auth.auth().currentUser
        
        if let user = user {
            UID = user.uid
        }
    }
    
    @IBAction func postClicked(_ sender: Any) {
        if imagePicked != nil {
            guard let data: Data = imagePicked!.jpegData(compressionQuality: 0.1) else {return}
            generateName()
            
            let imageRef = Storage.storage().reference().child("Posts/\(picName).jpeg")
            
            //uploading data to storage
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("Error occured. Error is \(String(describing: error))")
                    return
                }
            }
        } else {
            let alert = UIAlertController(title: "No image selected.", message: "Please select an image to post.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Dismiss", style: .default)
         
            alert.addAction(defaultAction)
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.present(alert, animated: true) {
                   // The alert was presented
                }
            }
        }
        
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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func generateName() {
        let randomTag = Int.random(in: 1000..<1000000)
        picName = UID + "-\(String(describing: randomTag))"
    }
}
