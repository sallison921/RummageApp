//
//  CreatedRecipesViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/30/21.
//

import UIKit

class CreatedRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var titleArray: [String] = []
    var imagesArray: [String] = []
    var detailsArray: [String] = []
    var ratingsArray: [String] = []
    var descriptionArray: [String] = []
    var trailerArray: [String] = []
    
    var upcoming: Bool!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "tableCells")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        
    }

    // MARK: - Table view data source

//    override func viewWillAppear(_ animated: Bool) {
//         titleArray = UserDefaults.standard.stringArray(forKey: "titleArray") ?? []
//        imagesArray = UserDefaults.standard.stringArray(forKey: "imagesArray") ?? []
//        detailsArray = UserDefaults.standard.stringArray(forKey: "detailsArray") ?? []
//        ratingsArray = UserDefaults.standard.stringArray(forKey: "ratingsArray") ?? []
//        descriptionArray = UserDefaults.standard.stringArray(forKey: "descriptionArray") ?? []
//        trailerArray = UserDefaults.standard.stringArray(forKey: "movieTrailerArray") ?? []
//        DispatchQueue.global(qos: .userInitiated).async {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//        }
//    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCells", for: indexPath)
        cell.textLabel?.text = titleArray[indexPath.row]
        
        let cellImageURL = imagesArray[indexPath.row]
       
        let url = URL(string: (cellImageURL))
        if url == nil {
            return cell
        }
        let data = try? Data(contentsOf: url!)
        guard let posterImage = UIImage(data: data!) else { return cell }
        cell.imageView?.image = posterImage
        
        return cell
    }
  
   
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete from array
            titleArray.remove(at: indexPath.row)
            imagesArray.remove(at: indexPath.row)
            detailsArray.remove(at: indexPath.row)
            ratingsArray.remove(at: indexPath.row)
            descriptionArray.remove(at: indexPath.row)
            trailerArray.remove(at: indexPath.row)
            
            //delete from table
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //reset user defaults
            UserDefaults.standard.set(titleArray, forKey: "titleArray")
            UserDefaults.standard.set(imagesArray, forKey: "imagesArray")
            UserDefaults.standard.set(detailsArray, forKey: "detailsArray")
            UserDefaults.standard.set(ratingsArray, forKey: "ratingsArray")
            UserDefaults.standard.set(descriptionArray, forKey: "descriptionArray")
            UserDefaults.standard.set(trailerArray, forKey: "movieTrailerArray")
            
            self.tableView.reloadData()
        }
    }
    //pass info to favorites
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chooseARecipe = ChosenRecipeViewController()
//        chooseARecipe.movieTitle = titleArray[indexPath.row]
//
//        let imgURL = imagesArray[indexPath.row]
//        let url = URL(string: (imgURL))
//        if url == nil {
//            return
//        }
//        let data = try? Data(contentsOf: url!)
//        guard let posterImage = UIImage(data: data!) else { return }
//        chooseARecipe.moviePic = posterImage
//        chooseARecipe.rating = ratingsArray[indexPath.row]
//        chooseFavoriteVC.movieDescription = descriptionArray[indexPath.row]
//        chooseFavoriteVC.moreDetails = detailsArray[indexPath.row]
//        chooseFavoriteVC.movieTrailer = trailerArray[indexPath.row]
//        chooseFavoriteVC.addBool = upcoming
        navigationController?.pushViewController(chooseARecipe, animated: true)
       
    }



}

