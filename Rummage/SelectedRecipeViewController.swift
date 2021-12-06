
import UIKit

class SelectedRecipeViewController: UIViewController {

//    var recipeInfo = UserDefaults.standard.stringArray(forKey: "RecipeSelected")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var recipeInfo = UserDefaults.standard.stringArray(forKey: "RecipeSelected")
        let view = UIView()
        let nLX = 160
        let nLY = 285
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 285))
        
        nameLabel.center = CGPoint(x: 160, y: 285)
        nameLabel.textAlignment = .center
        nameLabel.text = "747 drink"
        //nameLabel.text = recipeInfo?[0].strDrink

        view.addSubview(nameLabel)
        
        let instrLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        instrLabel.center = CGPoint(x: 160, y: nLY+285)
        instrLabel.textAlignment = .center
        instrLabel.text = "Fill a Collins glass with ice. Pour in vodka, lime cordial, and cranberry juice. Fill up with Sprite. Garnish with a Lime wheel or some cranberries"
        //instrLabel.text = recipeInfo[0]?.strInstructions

        view.addSubview(instrLabel)
////        recipeInfo = UserDefaults.standard.stringArray(forKey: "RecipeSelected")
//        let nLX = 160
//        let nLY = 285
//        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: nLX, height: nLY))
//        namelabel.center = CGPoint(x: 160, y: 285)
//        namelabel.textAlignment = .center
//        namelabel.text = recipeInfo.strDrink
//
//        self.view.addSubview(nameLabel)
//
//        let instrLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
//        instrLabel.center = CGPoint(x: 160, y: nLY+285)
//        instrLabel.textAlignment = .center
//        instrLabel.text = recipeInfo.strInstructions
//
//        self.view.addSubview(nameLabel)
//        // Do any additional setup after loading the view.
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
    
    var recipeInfo = UserDefaults.standard.stringArray(forKey: "RecipeSelected")
    
//    let recipeName = recipeInfo.strDrink
//    let recipeInstr = recipeInfo.strInstructions
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

