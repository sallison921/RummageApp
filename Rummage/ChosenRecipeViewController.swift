//
//  ChooseFavoriteViewController.swift
//  SydneyAllison-lab4
//
//  Created by Sydney A on 10/31/21.
//

import UIKit

class ChosenRecipeViewController: UIViewController {

    var movieDescription: String!
    var movieTitle: String!
    var moviePic: UIImage!
    var moreDetails: String!
    var rating: String!
    var movieURL: String!
    var movieTrailer: String!
    var watchTrailer: UIButton!
    

    var addBool: Bool!
    
    var scrollView: UIScrollView!
    var detailsContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        self.navigationItem.title = movieTitle
        
        //create a content view to append to scroll view
        detailsContentView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 100))
        //create scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = detailsContentView.bounds.size
        scrollView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        
        //image view
        let theImageFrame = CGRect(x: view.frame.midX - moviePic.size.width/6, y: detailsContentView.frame.minY + 30, width: moviePic.size.width/3, height: moviePic.size.height/3)
        let imageView = UIImageView(frame: theImageFrame)
        imageView.image = moviePic
        
        //title
        let titleText: UILabel = UILabel(frame: CGRect(x: view.frame.midX - (view.frame.width - 20)/2, y: theImageFrame.maxY + 15, width: view.frame.width - 20, height: 200))
        let myDescription = String(movieDescription)
        titleText.text = ("Overview: \(myDescription)")
        titleText.textAlignment = .center
        titleText.numberOfLines = 10
        
        //release date
        let releaseDateText: UILabel = UILabel(frame: CGRect(x: view.frame.midX - (view.frame.width - 20)/2, y: titleText.frame.maxY + 10, width: view.frame.width - 20, height: 25))
        let myReleaseDate = String(moreDetails)
        releaseDateText.text = ("Release date: \(myReleaseDate)")
        releaseDateText.textAlignment = .center

        //score (rating out of 10)
        let ratingText: UILabel = UILabel(frame: CGRect(x: view.frame.midX - (view.frame.width - 20)/2, y: releaseDateText.frame.maxY + 10, width: view.frame.width - 20, height: 25))
        let myRating = String(rating)
        ratingText.text = ("Score: \(myRating) / 10")
        ratingText.textAlignment = .center
        
      
        //add all subviews
        detailsContentView.addSubview(ratingText)
        detailsContentView.addSubview(titleText)
        detailsContentView.addSubview(releaseDateText)
        detailsContentView.addSubview(imageView)
        
        scrollView.addSubview(detailsContentView)
        
        view.addSubview(scrollView)
        
    }
    
    
}
