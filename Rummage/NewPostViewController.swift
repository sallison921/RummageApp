//
//  NewPostViewController.swift
//  Rummage
//
//  Created by Sydney A on 12/5/21.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var addPic: UIButton!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func postClicked(_ sender: Any) {
  
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
            postPicture.image = image
            self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
