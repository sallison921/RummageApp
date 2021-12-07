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
    
    /*TESTING
    struct recipeInfo:Decodable{
        let idDrink: String //id of drink in database
        let strDrink: String //name of drink
        let strInstructions: String //instructions on how to make the drink
        let strDrinkThumb: String //string url of image of drink
        let strIngredient1: String //ingredient 1
        let strIngredient2: String //ingredient 2
        let strIngredient3: String //ingredient 3
        let strIngredient4: String //ingredient 4
        let strIngredient5: String //ingredient 5
        let strIngredient6: String //ingredient 6
        let strIngredient7: String //ingredient 7
        let strIngredient8: String //ingredient 8
        let strIngredient9: String //ingredient 9
        let strIngredient10: String //ingredient 10
        let strIngredient11: String //ingredient 11
        let strIngredient12: String //ingredient 12
        let strIngredient13: String //ingredient 13
        let strIngredient14: String //ingredient 14
        let strIngredient15: String //ingredient 15
        let strMeasure1: String //measurement of ingredient 1
        let strMeasure2: String //measurement of ingredient 2
        let strMeasure3: String //measurement of ingredient 3
        let strMeasure4: String //measurement of ingredient 4
        let strMeasure5: String //measurement of ingredient 5
        let strMeasure6: String //measurement of ingredient 6
        let strMeasure7: String //measurement of ingredient 7
        let strMeasure8: String //measurement of ingredient 8
        let strMeasure9: String //measurement of ingredient 9
        let strMeasure10: String //measurement of ingredient 10
        let strMeasure11: String //measurement of ingredient 11
        let strMeasure12: String //measurement of ingredient 12
        let strMeasure13: String //measurement of ingredient 13
        let strMeasure14: String //measurement of ingredient 14
        let strMeasure15: String //measurement of ingredient 15
    }
    struct recipeSearchResults:Decodable{
        let drinks : [recipeInfo]
    }
    var curRSTotData = recipeSearchResults(drinks: [])
    var curRecipeSelectedData: [recipeInfo] = []
    @IBAction func getMargRecp(_ sender: Any) {
        let beginURL: String = "https://www.thecocktaildb.com/api/json/v2/9973533/search.php?s="
//        if(curRecipe.isEmpty){
//            curRecipe = "margarita"
//        }
        let totalURL = beginURL + "cosmopolitan"
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                curRSTotData = try! JSONDecoder().decode(recipeSearchResults.self, from:data)
            }
        }
        curRecipeSelectedData = curRSTotData.drinks
        var chosenRecipeSelectedData = curRecipeSelectedData[0].strDrink
        print("printing chosenSelectedData: ")
        print(chosenRecipeSelectedData)
        UserDefaults.standard.set(chosenRecipeSelectedData, forKey: "TestRecipeSelected")
        var testRecpInfo = UserDefaults.standard.object(forKey: "TestRecipeSelected") as? [String]
        var aName = testRecpInfo?[0]
        print("printing first element: ")
        print(aName)
    }
    DONE TESTING */
    
}

extension ViewController: ScannerViewDelegate {
    func didFindScannedText(text: String) {
        fetchDataForCollectionView(query: text)
    }
    
    func fetchDataForCollectionView(query: String) {
        let itemTitle = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.barcodelookup.com/v3/products?barcode=\(itemTitle!)&formatted=y&key=kgqaezw5p16xycgcaicj0kjz9rr6vb")
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

