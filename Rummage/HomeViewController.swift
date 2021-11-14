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
    
    var curTotData = recipeSearchResults(drinks: [])
    var curDrinkData: [recipeInfo] = []
    
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
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
    
        
        if(indexPath.section % 2 == 1){
            cell.backgroundColor = UIColor.blue
        } else {
           
            cell.backgroundColor = UIColor.red
           
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
                curTotData = try! JSONDecoder().decode(recipeSearchResults.self, from:data)
            }
        }
    }


}

