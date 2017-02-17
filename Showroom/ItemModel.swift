//
//  ItemModel.swift
//  YardSale
//
//  Created by Luke Mann on 2/5/17.
//  Copyright © 2017  All rights reserved.
//

import Foundation
import UIKit

struct StoreItem {
    var image:UIImage?
    var title:String?
    var description:String?
    var price:Double?
    var condition:Double?
    var ownerName:String?
    
    public mutating func editTitle(title:String){
        self.title=title
    }
    
    mutating func editImage(image:UIImage){
        self.image=image
    }
    
    mutating func editDescription(des:String){
        self.description=des
    }
    
    mutating func editPrice(price:Double){
        self.price=price
    }
    
    mutating func editRating(rating:Double){
        self.condition=rating
    }
}



