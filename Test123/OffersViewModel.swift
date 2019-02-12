//
//  OffersViewModel.swift
//  Test123
//
//  Created by Horatio Boothe on 8/18/18.
//  Copyright © 2018 Horatio Boothe. All rights reserved.
//

import Foundation
import UIKit

//OffersViewModel used as viewModel for ViewController's collection View
struct OffersViewModel {
    
    //data array used to populate store offers
    var offersData: [Offer]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfOffers: Int {
        return offersData.count
    }
    
    func name(for index: Int) -> String {
        return offersData[index].name
    }
    
    func description(for index: Int) -> String {
        return offersData[index].description
    }
    
    func url(for index: Int) -> String? {
        return offersData[index].url
    }
    
    func currentValue(for index: Int) -> String {
        return offersData[index].currentValue
    }
    
    func isFavorite(for index: Int) -> Bool {
        return offersData[index].isFavorite
    }
    
}
