//
//  DetailedViewController.swift
//  Rummage
//
//  Created by Michelle Zhou on 11/14/21.
//

import UIKit

class DetailedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let strings = ["gin","tonic water","rosemary", "vodka", "lemon", "cranberry juice"]
    let strings2 = ["blue margarita", "rosemary blue", "A Day at the Beach"]
    //lazy var data = [strings, curTotData] as [Any]
    lazy var data = [strings, strings2] //placeholder
    
    let headerTitles = ["Your Ingredients", "Recipes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count //2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor(named: "Pink")
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
  
        return cell
    }
    
    //titles for each section header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView
        headerView.headerTitle.text = headerTitles[section]
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
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
