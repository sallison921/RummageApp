//
//  ViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/9/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct APIResults:Decodable {
        let products: [Products]
    }
    
    struct Products:Decodable {
        let title: String
        let images: [String]
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanBarButton: UIButton!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    let scannerViewController = ScannerViewController()
    var theData:APIResults = APIResults(products: [])
    var ingredients:[String] = []
    let alert = UIAlertController(title: "Invalid Barcode", message: "Please try scanning a different item!", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanBarButton.addTarget(self, action: #selector(scanBarTapped), for: .touchUpInside)
        scannerViewController.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ingredientCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @objc func scanBarTapped() {
        self.navigationController?.pushViewController(scannerViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel!.text = ingredients[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
}

extension ViewController: ScannerViewDelegate {
    func didFindScannedText(text: String) {
        fetchDataForCollectionView(query: text)
    }
    
    func fetchDataForCollectionView(query: String) {
        let itemTitle = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.barcodelookup.com/v3/products?barcode=\(itemTitle!)&formatted=y&key=n8633av904wfnmbjsqm1mu3ihum8pw")
        if let data = try? Data(contentsOf: url!) {
            theData = try! JSONDecoder().decode(APIResults.self, from:data)
            let result = theData.products[0]
            //productLabel.text = ""
            ingredients.append(result.title)
            var list = ""
            for i in ingredients {
                list += "- "
                list += i
                list += "\n"
            }
            //productLabel.text = list
            //cacheImages(item: result)
            UserDefaults.standard.set(ingredients, forKey: "IngredientsScanned")
        }
        else {
            print("nothing found")
            let defaultAction = UIAlertAction(title: "Dismiss", style: .default)
            let alert = UIAlertController(title: "Invalid Barcode",
                    message: "Please try scanning a different item!",
                    preferredStyle: .alert)
            alert.addAction(defaultAction)
    
            let seconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.present(alert, animated: true) {
                   // The alert was presented
                }
            }
               
           
        }
    }
    
    func cacheImages(item: Products) {
        let link = item.images[0]
        
        if (link != ""){
            let url = URL(string: link)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            productImage.image = image
        }
        else {
            print("no image")
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        UserDefaults.standard.set(ingredients, forKey: "IngredientsScanned")
//    }
}

