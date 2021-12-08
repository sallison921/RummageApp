
import UIKit

class SelectedRecipeViewController: UIViewController, UITextFieldDelegate {

    var nameRecipe = UserDefaults.standard.string(forKey: "nameRecipeSelected")
    var instrRecipe = UserDefaults.standard.string(forKey: "instrRecipeSelected")
    var measurementRecipe = UserDefaults.standard.stringArray(forKey: "measurementsRecipeSelected")
    var ingredientsRecipe = UserDefaults.standard.stringArray(forKey: "ingredientsRecipeSelected")
    
    

    var addBool: Bool!
    
    var scrollView: UIScrollView!
    var detailsContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        self.navigationItem.title = nameRecipe
        
        //create a content view to append to scroll view
        detailsContentView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 100))
        //create scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = detailsContentView.bounds.size
        scrollView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        
        //instruction
        let instrText: UILabel = UILabel(frame: CGRect(x: view.frame.midX - (view.frame.width - 20)/2, y: detailsContentView.frame.minY + 30, width: view.frame.width - 20, height: 200))
        instrText.text = instrRecipe
        instrText.textAlignment = .center
        instrText.numberOfLines = 10
        
        //ingredients
        let ingrText: UILabel = UILabel(frame: CGRect(x: 0, y: instrText.frame.maxY, width: view.frame.width/2, height: 400))
        //let myDescription = instrRecipe
        var listIngr: String = ""
        for ingr in ingredientsRecipe!{
            listIngr = listIngr + ingr + " \n"
        }
        ingrText.text = listIngr
        ingrText.textAlignment = .center
        ingrText.numberOfLines = 10
        
        //measurements
        let measureText: UILabel = UILabel(frame: CGRect(x: ingrText.frame.maxX, y: instrText.frame.maxY, width: view.frame.width/2, height: 400))
        var measureIngr: String = ""
        for measure in measurementRecipe!{
            measureIngr = measureIngr + measure + " \n"
        }
        measureText.text = measureIngr
        measureText.textAlignment = .center
        measureText.numberOfLines = 10

        detailsContentView.addSubview(instrText)
        detailsContentView.addSubview(ingrText)
        detailsContentView.addSubview(measureText)
        
        scrollView.addSubview(detailsContentView)
        
        view.addSubview(scrollView)
        
    }
   
    
//    func setItems(){
//        recpName.text = nameRecipe
//        recpInstr.text = instrRecipe
//
//        var listIngr: String = ""
//        for ingr in measurementRecipe!{
//            listIngr = listIngr + ingr + " \n"
//        }
//        var measureIngr: String = ""
//        for measure in ingredientsRecipe!{
//            measureIngr = measureIngr + measure + " \n"
//        }
//
//        recpIngr.text = listIngr
//        recpMeasure.text = measureIngr
//    }
    
    
//    let recipeName = recipeInfo.strDrink
//    let recipeInstr = recipeInfo.strInstructions
   

}

