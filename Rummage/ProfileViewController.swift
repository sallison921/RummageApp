//
//  ProfileViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/30/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!

    //buttons on profile page
    //we can add little icons on top of each and make it look pretty
    @IBOutlet weak var createdRecipes: UIButton!
    @IBOutlet weak var followers: UIButton!
    @IBOutlet weak var yourPosts: UIButton!
    @IBOutlet weak var following: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
