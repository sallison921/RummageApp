//
//  NewPostViewController.swift
//  Rummage
//
//  Created by Sydney A on 12/5/21.
//

import UIKit

class NewPostViewController: UIViewController {

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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
