//
//  DetailedViewController.swift
//  Rummage
//
//  Created by Michelle Zhou on 11/14/21.
//

import UIKit

class DetailedViewController: UIViewController {
    
    
//    @IBOutlet weak var tableView: UITableView!
    
    var favRecipes: [String] = []
    
//    let strings = ["gin","tonic water","rosemary", "vodka", "lemon", "cranberry juice"]
//    let strings2 = ["blue margarita", "rosemary blue", "A Day at the Beach"]
    //lazy var data = [strings, curTotData] as [Any]
//    lazy var data = [strings, strings2] //placeholder
//
//    let headerTitles = ["Your Ingredients", "Recipes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUp()
//        let defaults = UserDefaults.standard
//        if var favs = defaults.array(forKey: "fav") as? [String] {
//            print("favs")
//            print(favs)
//                if(favs.count == 0) {
//                    print("nothing in here")
//                    favs = []
//                }
//                for recipe in favs {
//                    print(recipe)
//                    self.favRecipes.append(recipe)
//                }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//        }
//        else{
//            let favs:[String] = [String]()
//            UserDefaults.standard.set(favs, forKey: "fav")
//        }
    }
    
//    func setUp() {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = favRecipes[indexPath.row]
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let favs = defaults.array(forKey: "fav") as! [String]
        
        for title in favs {
            if((self.favRecipes.contains(title))) {
                print("already added")
            }
            else{
              self.favRecipes.append(title)
            }
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            favRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(favRecipes, forKey: "fav")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favRecipes.count
    }
    
    //titles for each section header
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView
//        headerView.headerTitle.text = headerTitles[section]
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 65
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
*/
}
