//
//  OfferCell.swift
//  Test123
//
//  Created by Horatio Boothe on 8/17/18.
//  Copyright © 2018 Horatio Boothe. All rights reserved.
//

import Foundation
import UIKit


class OfferCell: UICollectionViewCell {
    
    //Declare OfferCell properties
    var nameLabel: UILabel!
    
    var placeHolderImage:UIImage = UIImage(named: "placeHolder")!
    
    var offerImageView: UIImageView! 
    
    var amountLabel: UILabel!
    
    var imageBackGround: UIView!
    
    var spinner: UIActivityIndicatorView!
    
    var favoriteImageView: UIImageView?
    
    
    //Function to initialize UItableCell's properties
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Set background view to white
        self.contentView.backgroundColor = .white
        
        //Initialize favorite star for favorited offers
        favoriteImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        favoriteImageView?.image = #imageLiteral(resourceName: "filledStar")
        favoriteImageView?.contentMode = .scaleAspectFit
        favoriteImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Initialize and add image background and offerImageview
        let offerImageView = UIImageView(frame: .zero)
        imageBackGround = UIView(frame: .zero)
        offerImageView.translatesAutoresizingMaskIntoConstraints = false
        imageBackGround.translatesAutoresizingMaskIntoConstraints = false
        imageBackGround.backgroundColor = .gray
        contentView.addSubview(imageBackGround)
        offerImageView.contentMode = .scaleAspectFit
        offerImageView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    
        contentView.addSubview(offerImageView)
        self.offerImageView = offerImageView
        
        
        //Initialize amount label
        let amountLabel = UILabel(frame: .zero)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(amountLabel)
        self.amountLabel = amountLabel
        self.amountLabel.textAlignment = .left
        self.amountLabel.attributedText = setAttributes(for: "", colorValue: 0x4A4A4A, font: "AvenirNext-DemiBold", fontSize: 12)
        
        
        //Initialize name label
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nameLabel)
        
        self.nameLabel = nameLabel
        self.nameLabel.textAlignment = .left
        self.nameLabel.attributedText = setAttributes(for: "", colorValue: 0x4A4A4A, font: "AvenirNext-Regular", fontSize: 11)
        
        
        //Favorite image added at the top of cell
        contentView.addSubview(favoriteImageView!)
        favoriteImageView?.isHidden = true
        
        //Prepare constraints for offerImageView
        NSLayoutConstraint.activate([
            offerImageView.topAnchor.constraint(equalTo: imageBackGround.topAnchor, constant:6),
            offerImageView.bottomAnchor.constraint(equalTo: imageBackGround.bottomAnchor, constant: -6),
            offerImageView.leadingAnchor.constraint(equalTo: self.imageBackGround.leadingAnchor, constant: 6),
            offerImageView.trailingAnchor.constraint(equalTo: self.imageBackGround.trailingAnchor, constant: -6),
            ])
        
        //Prepare constraints for favoriteImageView
        NSLayoutConstraint.activate([
            (favoriteImageView?.topAnchor.constraint(equalTo: imageBackGround.topAnchor, constant:6))!,
            (favoriteImageView?.trailingAnchor.constraint(equalTo: self.imageBackGround.trailingAnchor, constant: -6))!,
            ])
        

        let cellWidth = (UIScreen.main.bounds.width - 32)/2

        //Prepare constraints for imageBackGround
        NSLayoutConstraint.activate([
            imageBackGround.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageBackGround.heightAnchor.constraint(equalToConstant: (0.647 * cellWidth)),
            imageBackGround.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageBackGround.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ])
        
        //Prepare contstraints for amount label
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: imageBackGround.bottomAnchor, constant: 8),
            amountLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            amountLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ])
        
        //Prepare constraints for nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3),
            nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ])
        
        
        //Set corner radius of gray background
        imageBackGround.layer.cornerRadius = 5
        imageBackGround.layer.masksToBounds = true
        
        
        //Initialize and Add activity indicator to cell
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(spinner)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        //Prepare spinner constraints
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.offerImageView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.offerImageView.centerYAnchor)
            ])
        
    }
    

//MARK: Font prep functions
    
    //Function to prepare name font
    func setName(name:String) {
        self.nameLabel.attributedText = setAttributes(for: name, colorValue: 0x4A4A4A, font: "AvenirNext-Regular", fontSize: 11)
    }
    
    //Function to prepare amount font
    func setAmount(amount:String) {
        self.amountLabel.attributedText = setAttributes(for: amount, colorValue: 0x4A4A4A, font: "AvenirNext-DemiBold", fontSize: 12)
    }
    
    private func setAttributes(for string: String, colorValue: Int, font: String, fontSize: CGFloat) -> NSAttributedString{
        
        let textAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor(rgb:colorValue),
            .font : UIFont(name: font, size: fontSize)!
        ]
        
        return NSAttributedString(string: string, attributes:textAttributes)
        
    }
    
    //Required for function for UICollectionViewCell class
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


