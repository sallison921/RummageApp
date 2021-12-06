//
//  ViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/9/21.
//

import UIKit

class ViewController: UIViewController {
    

    struct APIResults:Decodable {
        let products: [Products]
    }
    
    struct Products:Decodable {
        let title: String
        let images: [String]
    }
    
    @IBOutlet weak var scanTextField: UITextField!
    @IBOutlet weak var scanBarButton: UIButton!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    let scannerViewController = ScannerViewController()
    var theData:APIResults = APIResults(products: [])
    var ingredients:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanBarButton.addTarget(self, action: #selector(scanBarTapped), for: .touchUpInside)
        scannerViewController.delegate = self
    }
    
    @objc func scanBarTapped() {
        self.navigationController?.pushViewController(scannerViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension ViewController: ScannerViewDelegate {
    func didFindScannedText(text: String) {
        scanTextField.text = text
        fetchDataForCollectionView(query: text)
    }
    
    func fetchDataForCollectionView(query: String) {
        let itemTitle = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.barcodelookup.com/v3/products?barcode=\(itemTitle!)&formatted=y&key=28v9r6gmf41y1vj9bgqzp8rcqfr4rj")
        let data = try! Data(contentsOf: url!)
        theData = try! JSONDecoder().decode(APIResults.self, from:data)
        let result = theData.products[0]
        productLabel.text = ""
        ingredients.append(result.title)
        print(ingredients)
        var list = ""
        for i in ingredients {
            list += "- "
            list += i
            list += "\n"
        }
        print(list)
        productLabel.text = list
        //cacheImages(item: result)
        UserDefaults.standard.set(ingredients, forKey: "IngredientsScanned")
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

