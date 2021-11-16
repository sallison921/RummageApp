//
//  ViewController.swift
//  Rummage
//
//  Created by Sydney A on 11/9/21.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    struct APIResults:Decodable {
        let products: [Products]
    }
    
    struct Products:Decodable {
        let title: String
        let images: [String]
    }
    
    let scannerViewController = ScannerViewController()
    var theData:APIResults = APIResults(products: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBlue
        scanBarButton.addTarget(self, action: #selector(scanBarTapped), for: .touchUpInside)
        scannerViewController.delegate = self
    }
}

extension ViewController: ScannerViewDelegate {
    func didFindScannedText(text: String) {
        scanTextField.text = text
        fetchDataForCollectionView(query: text)
    }
    
    func fetchDataForCollectionView(query: String) {
        let itemTitle = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.barcodelookup.com/v3/products?barcode=\(itemTitle!)&formatted=y&key=fpgm6wv6vm8tp3wf8hwupzhi3gkpq2")
        let data = try! Data(contentsOf: url!)
        theData = try! JSONDecoder().decode(APIResults.self, from:data)
        let result = theData.products[0]
        productLabel.text = "Product: \(result.title)"
        cacheImages(item: result)
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
}

