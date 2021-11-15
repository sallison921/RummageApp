//
//  ViewController.swift
//  NicheApp
//
//  Created by Sydney A on 10/8/21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var curRecipe: String!
    // set this^^ when a recipe is clicked on
    
    var curItemsScanned: [String] = []
    // add to this^^ when an items are scanned
    
    //API key: 9973533
    
    var curRSTotData = recipeSearchResults(drinks: [])
    var curRecipeSelectedData: [recipeInfo] = []
    
    var curISTotData = recipeSearchResults(drinks: [])
    var curIngrToRecipeData: [recipeInfo] = []
    
    struct recipeSearchResults:Decodable{
        let drinks : [recipeInfo]
    }
    
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var myCGSize = CGSize(width: 350.0, height: 123.0)
//        if(indexPath.section == 2) {
//            myCGSize = CGSize(width: 152.5, height: 123.0)
//        }
//
//        return myCGSize
//    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)

        if indexPath.section == 0 && indexPath.row == 0 {
            let buttons: UIButton = UIButton(frame: CGRect(x: 0, y: 30, width: view.frame.width/4, height: 30))
            buttons.backgroundColor = .systemPink
            buttons.setTitle("Following", for: .normal)
            cell.addSubview(buttons)
//            buttons.addTarget(self, action:#selector(addedToFavorites(_:)), for: .touchUpInside)
            let forYouButton: UIButton = UIButton(frame: CGRect(x: buttons.frame.width + 40, y: 30, width: view.frame.width/4, height: 30))
            forYouButton.backgroundColor = .systemPink
            forYouButton.setTitle("For You", for: .normal)
            cell.addSubview(forYouButton)
        }
        else {
            let titleText: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 100))
            titleText.text = "Review!"
            titleText.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
            titleText.textColor = UIColor.black
            titleText.textAlignment = .center
        
            cell.addSubview(titleText)
        }
    
    
        
        return cell
        
    }
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    //should be called when a recipe is clicked on
    func getRecipe(){
        let beginURL: String = "www.thecocktaildb.com/api/json/v1/1/search.php?s="
        if(curRecipe.isEmpty){
            curRecipe = "margarita"
        }
        let totalURL = beginURL + curRecipe
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                curRSTotData = try! JSONDecoder().decode(recipeSearchResults.self, from:data)
            }
        }
        curRecipeSelectedData = curRSTotData.drinks
        
    }

    //called when scanner produces the name of the ingredient scanned
    //checks that the ingredients scanned appear in the database's list of ingredients, and removes an item from the array of scanned ingredients if it does not
    func isPresentAPI(){
        var ingrdMainData = recipeSearchResults(drinks: [])
        var totalIngrData: [recipeInfo]!
        
        let totalURL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                ingrdMainData = try! JSONDecoder().decode(recipeSearchResults.self, from:data)
            }
        }
        totalIngrData = ingrdMainData.drinks
        for existIngrDict in totalIngrData{
            let existIngr = existIngrDict.strIngredient1
            for scIngr in curItemsScanned{
                if(scIngr == existIngr){
                    break
                }
                else{
                    curItemsScanned = curItemsScanned.filter(){$0 != scIngr}
                    // ^^ removes items from scanned ingredient list
                }
            }
        }
    }

    //uses the current ingredients produced by the barcode scanner to search for recipes to make with them
    func ingrToRecipe(){
        var ingrToSearch: String = ""
        for ingr in curItemsScanned{
            if(curItemsScanned.firstIndex(of: ingr) == (curItemsScanned.count - 1)){
                ingrToSearch += ingr
            }
            else{
                ingrToSearch += ingr + ","
            }
        }
        
        let beginURL: String = "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i="
        if(ingrToSearch.isEmpty){
           ingrToSearch = "tonic_water,gin"
        }
        let totalURL = beginURL + ingrToSearch
        if let url = URL(string: totalURL){
            if let data = try? Data(contentsOf: url){
                curISTotData = try! JSONDecoder().decode(recipeSearchResults.self, from:data)
            }
        }
        
        curIngrToRecipeData = curISTotData.drinks
    }

}

