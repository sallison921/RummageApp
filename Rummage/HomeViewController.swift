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
    
    
    
}

