//
//  ViewController.swift
//  NicheApp
//
//  Created by Sydney A on 10/8/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //these allow for us to save/sync data to db
    var refUserInfo: DatabaseReference!
    var refPostInfo: DatabaseReference!
    var refObservers: [DatabaseHandle] = []
    
    var userInfo: NSDictionary = [
        "username": "fred",
        "pw": "12345",
        "postsMade": [1,2,3,4],
        //^^ thinking int so that we cant directly access the specific post in the DB with its unique id and extract it that way
        "recipesMade": ["a", "b","c","d"],
        "profPic": "put image in later pt.2",
        "bio": "fred of scooby doo"
    ]
//    ^^all the values here should be extracted from some sort of text form filled out when the user registers/logs in
    
    //var curUser = value(forKey: "username")
    
    var postInfo: NSDictionary = [
        "imageDrink": "put image in later pt. 2",
        "caption": "drink for scooby! URL of drink recipe",
        "postedBy": "fred"
    ]
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var myCGSize = CGSize(width: 350.0, height: 123.0)
//        if(indexPath.section == 2) {
//            myCGSize = CGSize(width: 152.5, height: 123.0)
//        }
//
//        return myCGSize
//    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)

     
            let titleText: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 100))
            titleText.text = "Review!"
            titleText.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
            titleText.textColor = UIColor.black
            titleText.textAlignment = .center
        
            cell.addSubview(titleText)
        
    
    
        
        return cell
        
    }
    
    
    @IBAction func addUser(_ sender: Any) {
        let fullUsername = userInfo["username"] as! String
        let newUserRef = refUserInfo.child(fullUsername.lowercased())
        //^^makes sure database saves only latest entry of the username (whether its all lower or all upper or mixed cased)
        newUserRef.setValue(userInfo)
    }
    
    @IBAction func addPost(_ sender: Any) {
        let fullUsername = userInfo["username"] as! String
        let newPostRef = refPostInfo.child(fullUsername.lowercased())
        //^^makes sure database saves only latest entry of the username (whether its all lower or all upper or mixed cased)
        newPostRef.setValue(postInfo)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        refUserInfo = Database.database().reference(withPath: "user-info")
        refPostInfo = Database.database().reference(withPath: "post-info")
    }
    
    
    
}

//sample data for DB

//{
//    "user-info":{
//        "username": {
//
//        }
//        "password": {
//
//        }
//        "postsMade": {
//
//        }
//        "recipesMade": {
//
//        }
//        "profPic": {
//
//        }
//        "bio": {
//
//        }
//    }
//}

//{
//    "post-info":{
//        "imageDrink": {
//
//        }
//        "caption": {
//
//        }
//        "postedBy": {
//
//        }
//    }
//}
