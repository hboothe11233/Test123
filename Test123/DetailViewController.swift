//
//  DetailViewController.swift
//  Test123
//
//  Created by Horatio Boothe on 8/19/18.
//  Copyright © 2018 Horatio Boothe. All rights reserved.
//

import Foundation
import UIKit

//DetailsViewController used to show details of an offer
class DetailViewController: UITableViewController {
    
//MARK: Properties
    var viewModel: OfferViewModel?
    
    var favoriteButton: UIButton!
    
    var favoriteImage:UIImage!
    
    var offerImageView: UIImageView!

    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = viewModel?.currentValue
        
        self.view.backgroundColor = .white
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.separatorStyle = .none

        setupOfferImage()
        
        setupFavoritesButton()
        
    }
    
    
    //Initialize Offer Image
    func setupOfferImage(){
        
        if let offerImage = viewModel?.image {
            offerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: offerImage.size.width, height: 90))
            offerImageView.contentMode = .scaleAspectFit
            offerImageView.image = offerImage
            if offerImage == #imageLiteral(resourceName: "placeHolder"){
                offerImageView.backgroundColor = .gray
                offerImageView.layer.cornerRadius = 5
                offerImageView.layer.masksToBounds = true
            }
        }
    }
    
    //Initialize favorite button
    func setupFavoritesButton() {
        favoriteImage = UIImage(named: (viewModel?.isFavorite)! ? "filledStar":"unfilledStar")
        
        
        favoriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: favoriteImage!.size.height))
        
        favoriteButton.setImage(favoriteImage , for: .normal)
        
        favoriteButton.setTitle((viewModel?.isFavorite)! ? "Remove from favorites?":"Add to favorites?", for: .normal)
        
        favoriteButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: (favoriteImage.size.width), bottom: 0, right: 0)
        
        favoriteButton.setTitleColor(.black, for: .normal)
        
        favoriteButton.contentHorizontalAlignment = .left
        favoriteButton.addTarget(self, action: #selector(changeFavorite), for: .touchUpInside)
    }
    

// MARK: Favorite Selector
    
    @objc func changeFavorite(){
        
        if (viewModel?.isFavorite)! {
            
            viewModel?.isFavorite = false
            
            favoriteImage = UIImage(named: "unfilledStar")
            favoriteButton.setTitle("Add to favorites?", for: .normal)
        }
        else{
            viewModel?.isFavorite = true
            
            favoriteImage = UIImage(named: "filledStar")
            favoriteButton.setTitle("Remove from favorites?", for: .normal)
        }
        
        favoriteButton.setImage(favoriteImage , for: .normal)
        
        favoriteButton.setNeedsDisplay()
        
    }
    
 
// MARK: TableView Delegate functions
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 140:UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    
// MARK: TableView Delegate functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //Set shared cell properties
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.textAlignment = .justified
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        // Configure the cell using switch via indices to dictate cell contents
        switch indexPath.row {
        case 0:
            cell.addSubview(offerImageView)
            offerImageView.center = cell.contentView.center
        case 1:
            cell.textLabel?.text = viewModel?.name
            cell.textLabel?.font = .boldSystemFont(ofSize: 20.0)
        case 2:
            cell.textLabel?.text = viewModel?.description
            cell.textLabel?.font = .boldSystemFont(ofSize: 17.0)
        case 3:
            cell.textLabel?.text = String("Offer ID: " + (viewModel?.id)!)
            cell.textLabel?.font = .systemFont(ofSize: 17)
        case 4:
            cell.textLabel?.text = viewModel?.terms
            cell.textLabel?.font = .systemFont(ofSize: 17)
        case 5:
            cell.contentView.addSubview(favoriteButton)
            favoriteButton.center = CGPoint(x: (favoriteButton.center.x + 15), y: cell.contentView.center.y)
            
        default:
                print("error")
        }
        
        return cell
    }
    
    
}
