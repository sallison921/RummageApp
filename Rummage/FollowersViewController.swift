//
//  FollowersViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/30/21.
//

import UIKit
import Firebase

class FollowersViewController: UIViewController {
    
    //@IBOutlet weak var tableView: UITableView!
    
    //these allow for us to save/sync data to db
    var refUserInfo: DatabaseReference!
    var UID = ""
    var username = ""
    var ref: DatabaseReference!
    var refObservers: [DatabaseHandle] = []
    var arr: [DataSnapshot] = []
    var keyarr: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "followersCell")
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
        
       
        //getInfo()
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        
    
       
        refUserInfo = Database.database().reference().child("user-info")
        refUserInfo?.observe(.childAdded) {(snapshot) in
          //self.arr.append(snapshot) // doing this, you can access the first child by contactListArray[0]
            
         // print(self.keyarr.count)
          // This is how to access info in your snapshot if you need it

          let key = snapshot.key //HERE: you'll get the keys
          let props = snapshot.value as! Dictionary<String, AnyObject>
          let userId = props["username"] //HERE: how to access to data
            //print(userId)
            self.keyarr.append(String(describing: userId))
            //print(key)
            print(self.keyarr.count)
        }
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "followersCell", for: indexPath)
        cell.textLabel?.text = "hi"
        //should be able to set this to the arr[indexPath.row] and itll put the username in there
        
        return cell
    }
    // MARK: - Table view data source


     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.keyarr.count)
        return keyarr.count

}
*/
}
