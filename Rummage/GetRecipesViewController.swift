//
//  GetRecipesViewController.swift
//  Rummage
//
//  Created by Tess Jenkins on 12/6/21.
//

import UIKit

class GetRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var curRecipe: String!
    // set this^^ when a recipe is clicked on
    
    var curItemsScanned: [String] = UserDefaults.standard.stringArray(forKey: "IngredientsScanned") ?? []
    // add to this^^ when an items are scanned
    
    var curItemProcessed: String = ""
    
    @IBOutlet weak var tableRecipes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if curItemsScanned == []{
            curItemsScanned = ["tonic_water","gin"]
        }
        self.tableRecipes!.register(UITableViewCell.self, forCellReuseIdentifier: "recipeCell")
        self.tableRecipes.dataSource = self
        self.tableRecipes.delegate = self
        //print(UserDefaults.standard.stringArray(forKey: "IngredientsScanned"))
        //getCranRecipe()
        isPresentAPI()
        getRecp()
        // Do any additional setup after loading the view.
    }
    
    //API key: 9973533
    
    //get rid of this all later!!!
    @IBOutlet weak var oneRecp: UILabel!
    @IBOutlet weak var twoRecp: UILabel!
    @IBOutlet weak var threeRecp: UILabel!
    @IBOutlet weak var fourRecp: UILabel!
    @IBOutlet weak var fiveRecp: UILabel!
    @IBOutlet weak var sixRecp: UILabel!
    @IBOutlet weak var sevenRecp: UILabel!
    @IBOutlet weak var eightRecp: UILabel!
    @IBOutlet weak var nineRecp: UILabel!
    @IBOutlet weak var tenRecp: UILabel!
    
    var curRSTotData = recipeSearchResults(drinks: [])
    var curRecipeSelectedData: [recipeInfo] = []

    var curISTotData = drinkSearchResults(drinks: [])
    var curIngrToRecipeData: [drinkList] = []
    
    var goalIngr: [String] = []
    
    struct drinkSearchResults:Decodable{
        let drinks : [drinkList]
    }
    struct drinkList:Decodable{
        let strDrink: String //name of drink
        let strDrinkThumb: String //string url of image of drink
        let idDrink: String //id of drink in database
    }
    
    struct existingDrink:Decodable{
        let strIngredient1: String //ingredient 1
    }
    struct listDrink:Decodable{
        let drinks : [existingDrink]
    }
    
    struct recipeSearchResults:Decodable{
        let drinks : [recipeInfo]
    }
    struct recipeInfo:Decodable{
        let idDrink: String //id of drink in database
        let strDrink: String //name of drink
        let strInstructions: String //instructions on how to make the drink
        let strDrinkThumb: String //string url of image of drink
        let strIngredient1: String! //ingredient 1
        let strIngredient2: String! //ingredient 2
        let strIngredient3: String! //ingredient 3
        let strIngredient4: String! //ingredient 4
        let strIngredient5: String! //ingredient 5
        let strIngredient6: String! //ingredient 6
        let strIngredient7: String! //ingredient 7
        let strIngredient8: String! //ingredient 8
        let strIngredient9: String!//ingredient 9
        let strIngredient10: String! //ingredient 10
        let strIngredient11: String! //ingredient 11
        let strIngredient12: String! //ingredient 12
        let strIngredient13: String! //ingredient 13
        let strIngredient14: String! //ingredient 14
        let strIngredient15: String! //ingredient 15
        let strMeasure1: String! //measurement of ingredient 1
        let strMeasure2: String! //measurement of ingredient 2
        let strMeasure3: String! //measurement of ingredient 3
        let strMeasure4: String! //measurement of ingredient 4
        let strMeasure5: String! //measurement of ingredient 5
        let strMeasure6: String! //measurement of ingredient 6
        let strMeasure7: String! //measurement of ingredient 7
        let strMeasure8: String! //measurement of ingredient 8
        let strMeasure9: String! //measurement of ingredient 9
        let strMeasure10: String! //measurement of ingredient 10
        let strMeasure11: String! //measurement of ingredient 11
        let strMeasure12: String! //measurement of ingredient 12
        let strMeasure13: String! //measurement of ingredient 13
        let strMeasure14: String! //measurement of ingredient 14
        let strMeasure15: String! //measurement of ingredient 15
    }
    
//    struct specRecipeInfo:Decodable{
//        let idDrink: String //id of drink in database
//        let strDrink: String //name of drink
//        let strDrinkAlternative: String
//        let strTags: String
//        let strVideo: String
//        let strCategory: String
//        let strIBA: String
//        let strAlcoholic: String
//        let strInstructions: String //instructions on how to make the drink
//        let strDrinkThumb: String //string url of image of drink
//        let strIngredient1: String //ingredient 1
//        let strIngredient2: String //ingredient 2
//        let strIngredient3: String //ingredient 3
//        let strIngredient4: String //ingredient 4
//        let strIngredient5: String //ingredient 5
//        let strIngredient6: String //ingredient 6
//        let strIngredient7: String //ingredient 7
//        let strIngredient8: String //ingredient 8
//        let strIngredient9: String //ingredient 9
//        let strIngredient10: String //ingredient 10
//        let strIngredient11: String //ingredient 11
//        let strIngredient12: String //ingredient 12
//        let strIngredient13: String //ingredient 13
//        let strIngredient14: String //ingredient 14
//        let strIngredient15: String //ingredient 15
//        let strMeasure1: String //measurement of ingredient 1
//        let strMeasure2: String //measurement of ingredient 2
//        let strMeasure3: String //measurement of ingredient 3
//        let strMeasure4: String //measurement of ingredient 4
//        let strMeasure5: String //measurement of ingredient 5
//        let strMeasure6: String //measurement of ingredient 6
//        let strMeasure7: String //measurement of ingredient 7
//        let strMeasure8: String //measurement of ingredient 8
//        let strMeasure9: String //measurement of ingredient 9
//        let strMeasure10: String //measurement of ingredient 10
//        let strMeasure11: String //measurement of ingredient 11
//        let strMeasure12: String //measurement of ingredient 12
//        let strMeasure13: String //measurement of ingredient 13
//        let strMeasure14: String //measurement of ingredient 14
//        let strMeasure15: String //measurement of ingredient 15
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return curIngrToRecipeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel!.text = curIngrToRecipeData[indexPath.row].strDrink
        curRecipe = curIngrToRecipeData[indexPath.row].strDrink
        //getRecipe()
//        let selectRecpVC = SelectedRecipeViewController()
//        navigationController?.pushViewController(selectRecpVC, animated: true)

//        let listRecVC = ListRecViewController()
//        listRecVC.myArray = listNames
//
//        navigationController?.pushViewController(listRecVC, animated: true)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curRecipe = curIngrToRecipeData[indexPath.row].strDrink
        getRecipe()
        let selectRecpVC = SelectedRecipeViewController()
        navigationController?.pushViewController(selectRecpVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: "Add to Favorite", handler: {(ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.addToFavs(recipe: self.curIngrToRecipeData[indexPath.row].strDrink)
            success(true)
        })
        favAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [favAction])
    }
    
    @objc func addToFavs(recipe:String) {
        print("add to favs")
        let defaults = UserDefaults.standard
        
        if var favs = defaults.array(forKey: "fav") as? [String] {
            if (favs.count == 0) {
                favs = [recipe]
            }
            else {
                if(favs.contains(recipe)){
                    print("already exists")
                }
                else {
                    favs.append(recipe)
                }
            }
            defaults.set(favs, forKey: "fav")
        }
        else {
            let favs:[String] = [String]()
            UserDefaults.standard.set(favs, forKey: "fav")
        }
    }
    
    //should be called when a recipe is clicked on
    func getRecipe(){
        let beginURL: String = "https://www.thecocktaildb.com/api/json/v2/9973533/search.php?s="
        if(curRecipe.isEmpty){
            curRecipe = "margarita"
        }
        let recpToArray = curRecipe.components(separatedBy: " ")
        let backToString = recpToArray.joined(separator: "_")
        curRecipe = backToString
        let totalURL = beginURL + curRecipe
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                curRSTotData = try! JSONDecoder().decode(recipeSearchResults.self, from:data)
            }
        }
        curRecipeSelectedData = curRSTotData.drinks
        let nameRecipeSelectedData = curRecipeSelectedData[0].strDrink
        let instrRecipeSelectedData = curRecipeSelectedData[0].strInstructions
        UserDefaults.standard.set(nameRecipeSelectedData, forKey: "nameRecipeSelected")
        UserDefaults.standard.set(instrRecipeSelectedData, forKey: "instrRecipeSelected")
        let arrMeasurements = [curRecipeSelectedData[0].strMeasure1, curRecipeSelectedData[0].strMeasure2, curRecipeSelectedData[0].strMeasure3 , curRecipeSelectedData[0].strMeasure4 , curRecipeSelectedData[0].strMeasure5 , curRecipeSelectedData[0].strMeasure6 , curRecipeSelectedData[0].strMeasure7 , curRecipeSelectedData[0].strMeasure8 , curRecipeSelectedData[0].strMeasure9 , curRecipeSelectedData[0].strMeasure10 , curRecipeSelectedData[0].strMeasure11 , curRecipeSelectedData[0].strMeasure12 , curRecipeSelectedData[0].strMeasure13, curRecipeSelectedData[0].strMeasure14 , curRecipeSelectedData[0].strMeasure15 ]
        let arrIngredients = [curRecipeSelectedData[0].strIngredient1, curRecipeSelectedData[0].strIngredient2, curRecipeSelectedData[0].strIngredient3 , curRecipeSelectedData[0].strIngredient4 , curRecipeSelectedData[0].strIngredient5 , curRecipeSelectedData[0].strIngredient6 , curRecipeSelectedData[0].strIngredient7 , curRecipeSelectedData[0].strIngredient8 , curRecipeSelectedData[0].strIngredient9 , curRecipeSelectedData[0].strIngredient10 , curRecipeSelectedData[0].strIngredient11 , curRecipeSelectedData[0].strIngredient12 , curRecipeSelectedData[0].strIngredient13 , curRecipeSelectedData[0].strIngredient14 , curRecipeSelectedData[0].strIngredient15 ]
        UserDefaults.standard.set(arrMeasurements, forKey: "measurementsRecipeSelected")
        UserDefaults.standard.set(arrIngredients, forKey: "ingredientsRecipeSelected")
        
    }

    //called when scanner produces the name of the ingredient scanned
    //checks that the ingredients scanned appear in the database's list of ingredients, and removes an item from the array of scanned ingredients if it does not
    func isPresentAPI(){
        var ingrdMainData = listDrink(drinks: [])
//        var ingrdMainData = recipeSearchResults(drinks: [])
        var totalIngrData: [existingDrink]!
        
        let totalURL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                ingrdMainData = try! JSONDecoder().decode(listDrink.self, from:data)
            }
        }
        totalIngrData = ingrdMainData.drinks
        //var count = 0
        outerMostLoop:
        for existIngrDict in totalIngrData{
            let existIngr = existIngrDict.strIngredient1
            //var goalIngr: [String] = []
            outerLoop:
            for scIngr in curItemsScanned{
                if(scIngr == existIngr){
                   break
                }
                else{
                    func breakItem(fromCSVString str: String) -> [String]{
                        let separators = CharacterSet(charactersIn: " -")
                        return str.components(separatedBy: separators)
                    }
                   let brokenItem = breakItem(fromCSVString: scIngr)
                    var goalItem: String = ""
                    innerLoop:
                    for specBI in brokenItem{
                        if(specBI == existIngr){
                            goalItem = specBI
                            break innerLoop
                        }
                        else if(existIngr.contains(specBI)){
//                            let index = brokenItem.firstIndex(of: specBI)
//                            brokenItem[index!] = existIngr
                            goalItem = existIngr
                            break innerLoop
                        }
                        else{
                        }
                    }
                    if(goalItem.isEmpty == false){
                        goalIngr.append(goalItem)
                    }
//                    if(brokenItem.count != 0){
//                        let index2 = curItemsScanned.firstIndex(of: scIngr)
//                        curItemsScanned[index2!] = brokenItem[0]
//                    }
                   // ^^ removes items from scanned ingredient list
                }
            }
        }
        
    }

    //uses the current ingredients produced by the barcode scanner to search for recipes to make with them
    func ingrToRecipe(){
//        var ingrToSearch: String = ""
//        for ingr in curItemsScanned{
//            if(curItemsScanned.firstIndex(of: ingr) == (curItemsScanned.count - 1)){
//                ingrToSearch += ingr
//            }
//            else{
//                ingrToSearch += ingr + ","
//            }
//        }
//
//        let beginURL: String = "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i="
//        if(ingrToSearch.isEmpty){
//           ingrToSearch = "tonic_water,gin"
//        }
//        let totalURL = beginURL + ingrToSearch
//        if let url = URL(string: totalURL){
//            if let data = try? Data(contentsOf: url){
//                curISTotData = try! JSONDecoder().decode(drinkSearchResults.self, from:data)
//            }
//        }
        let beginURL: String = "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i="
        let totalURL = beginURL + curItemProcessed
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                curISTotData = try! JSONDecoder().decode(drinkSearchResults.self, from:data)
            }
        }
        
        curIngrToRecipeData
            += curISTotData.drinks
    }

    
    
    func getRecp(){
        //curItemsScanned = ["vodka","cranberry_juice"]
        for ingr in goalIngr{
            curItemProcessed = ingr
            ingrToRecipe()
        }
        //just make a tableview for this instead of the below hardcoded
//        oneRecp.text = curIngrToRecipeData[0].strDrink
//        twoRecp.text = curIngrToRecipeData[1].strDrink
//        threeRecp.text = curIngrToRecipeData[2].strDrink
//        fourRecp.text = curIngrToRecipeData[3].strDrink
//        fiveRecp.text = curIngrToRecipeData[4].strDrink
//        sixRecp.text = curIngrToRecipeData[5].strDrink
//        sevenRecp.text = curIngrToRecipeData[6].strDrink
//        eightRecp.text = curIngrToRecipeData[7].strDrink
//        nineRecp.text = curIngrToRecipeData[8].strDrink
//        tenRecp.text = curIngrToRecipeData[9].strDrink
    }
    
    func getCranRecipe(){
        let beginURL: String = "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i="
        let totalURL = beginURL + "cranberry_juice"
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                curISTotData = try! JSONDecoder().decode(drinkSearchResults.self, from:data)
            }
        }
        
        curIngrToRecipeData
            += curISTotData.drinks
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
     if(scIngr == existIngr){
//                    break
//                }
////                else if(scIngr.prefix(3) == existIngr.prefix(3)){
////                    curItemsScanned[count] = existIngr
////                }
////                else if(scIngr.suffix(3) == existIngr.suffix(3)){
////                    curItemsScanned[count] = existIngr
////                }
//                else{
//                    curItemsScanned = curItemsScanned.filter(){$0 != scIngr}
//                    // ^^ removes items from scanned ingredient list
//                }
     */

}
