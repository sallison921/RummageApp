//
//  ViewController.swift
//  NicheApp
//
//  Created by Sydney A on 10/8/21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
        collectionView.dataSource = self

    }


}

