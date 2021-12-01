//
//  FollowingViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/30/21.
//

import UIKit

class FollowingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "followingCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
       

        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "followingCell", for: indexPath)
       
       
        return cell
    }
    // MARK: - Table view data source


     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10


    
  
   



}

}
