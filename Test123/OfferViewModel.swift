//
//  OffersViewViewModel.swift
//  Test123
//
//  Created by Horatio Boothe on 8/17/18.
//  Copyright © 2018 Horatio Boothe. All rights reserved.
//

import Foundation
import UIKit

//OfferViewModel used to pass / set offer data along to and from DetailsViewController
struct OfferViewModel {
    
    let offerData: Offer
    
    var name: String{
        return offerData.name
    }
    
    var id: String{
        return offerData.id
    }
    
    var url: String{
        return offerData.url!
    }
    
    var description: String{
        return offerData.description
    }
    
    var terms: String{
        return offerData.terms
    }
    
    var currentValue: String{
        return offerData.currentValue
    }
    
    var isFavorite: Bool{
        get{
            return offerData.isFavorite!
        }
        set{
            offerData.isFavorite = newValue
        }
    }
    
    var image: UIImage?
}
