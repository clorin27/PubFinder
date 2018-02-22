//
//  IrishPubItem.swift
//  IrishPubFinder
//
//  Created by Christelle Lorin on 2/15/18.
//

import UIKit

class IrishPubItem {
    
    var title = ""
    var distance = 0
    var rating = ""
    var priceTier = ""
    var url = ""
    
    
    init(title:String, distance: Int, rating: String, priceTier: String, url: String) {
        self.title = title
        self.distance = distance
        self.rating = rating
        self.priceTier = priceTier
        self.url = url
        
    }

}
