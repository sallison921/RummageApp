
import UIKit

class SelectedRecipeViewController: UIViewController {

    var nameRecipe = UserDefaults.standard.string(forKey: "nameRecipeSelected")
    var instrRecipe = UserDefaults.standard.string(forKey: "instrRecipeSelected")
    var measurementRecipe = UserDefaults.standard.stringArray(forKey: "measurementsRecipeSelected")
    var ingredientsRecipe = UserDefaults.standard.stringArray(forKey: "ingredientsRecipeSelected")
    
    @IBOutlet weak var recpName: UITextField!
    @IBOutlet weak var recpInstr: UITextView!
    @IBOutlet weak var recpIngr: UITextView!
    @IBOutlet weak var recpMeasure: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setItems()
//        // Do any additional setup after loading the view.
        
    }
    
//    struct recipeInfo:Decodable{
//        let idDrink: String //id of drink in database
//        let strDrink: String //name of drink
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
    
    func setItems(){
        recpName.text = nameRecipe
        recpInstr.text = instrRecipe
        var listIngr: String = ""
        for ingr in measurementRecipe!{
            if ingr.isEmpty{
                break
            }
            listIngr = listIngr + ingr + " \n"
        }
        var measureIngr: String = ""
        for measure in ingredientsRecipe!{
            if measure.isEmpty{
                break
            }
            measureIngr = measureIngr + measure + " \n"
        }
        recpIngr.text = listIngr
        recpMeasure.text = measureIngr
    }
    
    
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

