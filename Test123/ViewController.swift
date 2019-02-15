//
//  ViewController.swift
//  Test123
//
//  Created by Horatio Boothe on 8/3/18.
//  Copyright © 2018 Horatio Boothe. All rights reserved.
//

import UIKit
import Foundation


//Statements to parse offer json
typealias Offers = [Offer]

let fileName = "Offers_data"
let url = Bundle.main.url(forResource: fileName, withExtension: "json")
let jsonData = try! Data(contentsOf: url!)

let offers = try? JSONDecoder().decode(Offers.self, from: jsonData)





//ViewController used to display OfferCells within a collectionView
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Declare collection view to be added to ViewController...
    var offersCollection:UICollectionView!
    
    //Initialize viewmodel with offer data
    var viewModel:OffersViewModel? = OffersViewModel(offersData: offers!)
    

    
//MARK: ViewDidLoad
    
    //ViewDidLoad used to set navigation title and initialize the collectionView
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Offers"
    
        setupCollectionView()
    }
    
    
    //Setup and add Collectionview as subview
    func setupCollectionView(){
        offersCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), collectionViewLayout: UICollectionViewFlowLayout.init())
        
        offersCollection!.contentInset = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
        
        offersCollection.register(OfferCell.self, forCellWithReuseIdentifier: "Cell")
        offersCollection.delegate = self
        offersCollection.dataSource = self
        offersCollection.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.view.addSubview(offersCollection!)
    }
    
    
    
//MARK: ViewWillAppear
    
    //ViewWillAppear used to reload selected OfferCell
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let selectedIndexPath = offersCollection.indexPathsForSelectedItems?.first else{
            return
        }
        
        offersCollection.reloadItems(at: offersCollection.indexPathsForSelectedItems!)
        
        let selectedCell = (offersCollection.cellForItem(at: selectedIndexPath) as! OfferCell)
        selectedCell.isSelected = false
        
    }
    


//MARK: CollectionView datasoure functions
    
    //Get number of items in collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.numberOfOffers)!
    }
    
    
    //Cell-for-item-at function used to specify values for cell properties
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OfferCell
        
        if let viewModel = viewModel {
            
            cell.setName(name: viewModel.name(for: indexPath.item))
            
            cell.setAmount(amount: viewModel.currentValue(for: indexPath.item))
            
            if let tempLink = viewModel.url(for: indexPath.item) {
                
                //Async call to get offer image
                DispatchQueue.global().async {
                    do{
                        let url = URL(string : tempLink)!
                        let data = try Data(contentsOf: url)
                        
                        //aSync update to load images on main queue
                        DispatchQueue.main.async{
                            cell.offerImageView.image = UIImage(data: data)
                            cell.spinner.stopAnimating()
                            cell.favoriteImageView?.isHidden = !viewModel.isFavorite(for: indexPath.item)
                        }
                    } catch {
                        //handle catch error ... no error handling added at this point
                    }
                }
            }
            else{
                //Add placeholder image ... Could have been set in OfferCell.swift, but looks unappealing with spinner
                cell.offerImageView.image = #imageLiteral(resourceName: "placeHolder")
                cell.spinner.stopAnimating()
                cell.favoriteImageView?.isHidden = !viewModel.isFavorite(for: indexPath.item)
            }
            
        }
        
        return cell;
    }
    
    
    
//MARK: CollectionView Delegate function
    
    //Function to handle cell selection and navigation to DetailView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell: OfferCell = (offersCollection.cellForItem(at: indexPath) as? OfferCell)!
        
        guard let offerImage = selectedCell.offerImageView.image else {
            return
        }
        
        let detailVC: DetailViewController = DetailViewController()
        
        detailVC.viewModel = OfferViewModel(offerData:offers![indexPath.item], image: offerImage)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
//MARK: CollectionViewLayout Delegate functions
    
    //Function to set OfferCell (UICollectionCell) dimensions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (self.view.bounds.width/2) - 16
        
        return CGSize(width: width, height: width * 0.87)
    }
    
    
    //Function to set vertical linespacing between cell rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    //Function to set horizontal spacing between cell rows... Not really being used at this point
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


    
    


}

