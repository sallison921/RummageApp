//
//  ViewController.swift
//  NicheApp
//
//  Created by Sydney A on 10/8/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

//    @IBOutlet var collectionView: UICollectionView!
    

    
    
    //these allow for us to save/sync data to db
    var refUserInfo: DatabaseReference!
    var refPostInfo: DatabaseReference!
    var ref: DatabaseReference!
    var refObservers: [DatabaseHandle] = []
    var arr: [DataSnapshot] = []
    var keyarr = [String]()
    
    var UID = ""
    var userPosts: [String] = []
    var captions: [String] = []
    
//    var userInfo: NSDictionary!
//    var postInfo: NSDictionary!
        
    
//    func getInfo() {
//        let user = Auth.auth().currentUser
//        if let user = user {
//            ref = Database.database().reference().child("user-info")
//            ref.child(user.uid).observe(.value, with: { snapshot in
//                let profile = snapshot.value as? [String: String]
//                let name = profile?["username"]
//                let biography = profile?["bio"]
//                let pfp = profile?["pfp"]
//
//                self.username.text = name
//                self.bio.text = biography
//
//                self.pfpName = pfp ?? "no_profile.png"
//                self.profilePicture()
//            })
//        }
//    }
    
    @IBOutlet weak var spongePic: UIImageView!
    @IBOutlet weak var barackPicture: UIImageView!
    @IBOutlet weak var hannahPic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
        refUserInfo = Database.database().reference(withPath: "user-info")
        refPostInfo = Database.database().reference(withPath: "post-info")
        spongePic.image = UIImage(named: "spongebobDrink")
        barackPicture.image = UIImage(named: "barackPic")
        hannahPic.image = UIImage(named: "hannahPic")
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.updating()
            DispatchQueue.main.async {
                //self.collectionView.reloadData()
            }
        }
       
    }
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
        print("num")
        return keyarr.count
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var myCGSize = CGSize(width: 350.0, height: 123.0)
//        if(indexPath.section == 2) {
//            myCGSize = CGSize(width: 152.5, height: 123.0)
//        }
//
//        return myCGSize
//    }
   
/*
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collec")
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
      
        
        let author: String = refPostInfo.child("post").child(keyarr[indexPath.item]).value(forKey: "author") as! String
        let capText: String = refPostInfo.child("post").child(keyarr[indexPath.item]).value(forKey: "caption") as! String
        print(author)
        print(capText)
        let titleText: UILabel = UILabel(frame: CGRect(x: 0, y: 160, width: cell.frame.width, height: 30))
        titleText.text =  capText
        titleText.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        titleText.textColor = UIColor.black
        titleText.textAlignment = .center
        
        let authorText: UILabel = UILabel(frame: CGRect(x: 0, y: 100, width: cell.frame.width, height: 30))
        authorText.text =  author
        authorText.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        authorText.textColor = UIColor.black
        authorText.textAlignment = .center

        //create an image view for image
//       let img:UIImageView = UIImageView(frame: cell.frame)
//        let image:UIImage = theImageCache[indexPath.row]
//        img.image = image

        //add text to image and set it as background
       
        cell.addSubview(titleText)
        cell.addSubview(authorText)
        
//        cell.postCaption.text = titleText
//        cell.postUsername.text = author
//            let titleText: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 100))
//            titleText.text = "Review!"
//            titleText.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
//            titleText.textColor = UIColor.black
//            titleText.textAlignment = .center
//
//            cell.addSubview(titleText)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       return true
   }
    */
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
        postPic.image = UIImage(named: "martini")
        postCap.text = UserDefaults.standard.string(forKey: "newPostCap")
    }
    
    

    
 
        //updating()
    
    func updating(){
//        refPostInfo.child("posts/author").getData(completion: { error, snapshot in
//            guard error == nil else {
//              print(error!.localizedDescription)
//              return;
//            }
//            let userName = snapshot.value as? String ?? "Unknown"
//            print(userName)
//          });

          print("update")
          refPostInfo?.observe(.childAdded) {(snapshot) in
            self.arr.append(snapshot) // doing this, you can access the first child by contactListArray[0]
            self.keyarr.append(snapshot.key)
            print(self.keyarr.count)
            // This is how to access info in your snapshot if you need it

            let key = snapshot.key //HERE: you'll get the keys
            let props = snapshot.value as! Dictionary<String, AnyObject>
            //let userId = props["userId"] //HERE: how to access to data
          }
        

    }
//    override func viewWillAppear(_ animated: Bool) {
//        print("appear")
//
//
//
//    }
   
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
