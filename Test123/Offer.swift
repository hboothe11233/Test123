//
//  Offer.swift
//  Test123
//
//  Created by Horatio Boothe on 8/17/18.
//  Copyright © 2018 Horatio Boothe. All rights reserved.
//

import Foundation

//Offer model, with added isFavorite var
class Offer: Codable {
    let id: String
    let url: String?
    let name, description, terms, currentValue: String
    
    var isFavorite: Bool! = false
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, description, terms
        case currentValue = "current_value"
    }
    
    init(id: String, url: String?, name: String, description: String, terms: String, currentValue: String) {
        self.id = id
        self.url = url
        self.name = name
        self.description = description
        self.terms = terms
        self.currentValue = currentValue
    }
}


