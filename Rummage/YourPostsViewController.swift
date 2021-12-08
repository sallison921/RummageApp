//
//  YourPostsViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/30/21.
//

import UIKit
import Firebase

class YourPostsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    var ref: DatabaseReference!
    var UID = ""
    var userPosts: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

       
  
    func getInfo() {
        let user = Auth.auth().currentUser
        
        if let user = user {
            UID = user.uid
            let storageReference = Storage.storage().reference().child("Posts/\(UID)")
            storageReference.listAll(completion:{ (result, error) in
              if let error = error {
                print(error)
              }
              for item in result.items {
                let toString = String(describing: item)
                print(toString)
                self.userPosts.append(toString)
              }
//                self.ref = Database.database().reference().child("post-info")
//                self.ref.child(user.uid).observe(.value, with: { snapshot in
//                    let captionText = snapshot.value as? [String: String]
//                    let theText = captionText?["caption"]
//                   print(theText)
//
//
               // })
                
                
                
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            })
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
   }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       //create cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yourPostsReuse", for: indexPath) as? YourPostCollectionViewCell else {
            fatalError("Could not retrieve cell.")
        }
        let postName = userPosts[indexPath.item]
        let ref = Storage.storage().reference(forURL: postName)
        //let nameRef = Storage.storage().reference(withPath: <#T##String#>)
   
        ref.getData(maxSize: 1*1024*1024, completion: { (data, error) in
            if let error = error {
                print("Error occurred \(String(describing: error))")
            } else {
                let image = UIImage(data: data!)
                cell.postImage.image = image
                print("gpt here")
       
                print(ref.child("/Caption"))
              // cell.postCaption.text = "new text"
                
            }
        })
        
        //create a uilabel for the title
//        let titleText: UILabel = UILabel(frame: CGRect(x: 0, y: 160, width: cell.frame.width, height: 30))
//        titleText.text = upcomingArray[indexPath.row].title
//        titleText.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
//        titleText.textColor = UIColor.white
//        titleText.textAlignment = .center
//
//        //create an image view for image
//       let img:UIImageView = UIImageView(frame: cell.frame)
//        let image:UIImage = theImageCache[indexPath.row]
//        img.image = image

        //add text to image and set it as background
//        img.addSubview(titleText)
//        cell.backgroundView = img
        
        return cell
    }
    
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//          //send over all data
//          let detailedVC = ChooseMovieViewController()
//          detailedVC.moviePic = theImageCache[indexPath.row]
//          detailedVC.movieDescription = upcomingArray[indexPath.row].overview
//          detailedVC.moreDetails = upcomingArray[indexPath.row].release_date
//          detailedVC.movieTitle = upcomingArray[indexPath.row].title
//          detailedVC.rating = upcomingArray[indexPath.row].vote_average
//        detailedVC.movieID = String(upcomingArray[indexPath.row].id)
//        detailedVC.movieTrailer = trailerArray[indexPath.row].key
//        detailedVC.addBool = true
//
//          detailedVC.navigationItem.title = upcomingArray[indexPath.row].title
//          let posterPathToSend = upcomingArray[indexPath.row].poster_path
//          let urlBase = "https://image.tmdb.org/t/p/w500"
//          var urlRest = ""
//
//          if (posterPathToSend == nil){
//              urlRest =  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/No_image_available_450_x_600.svg/450px-No_image_available_450_x_600.svg.png"
//          }
//          //if there is a path, set the url to be the base + the path
//          else{
//              urlRest = urlBase + (posterPathToSend ?? "")
//          }
//          detailedVC.movieURL = urlRest
//
          //push new view controller
//          navigationController?.pushViewController(detailedVC, animated: true)

      }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       return true
   }
}

