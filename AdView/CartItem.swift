//
//  CartItem.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-02.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
import CoreData
@objc(CartItem)
class CartItem {
    init(){
        self.link = ""
        self.name = ""
        self.image = ""
        self.pid = ""
        self.subtitle = "asdf asdf "
    }
    var link: String
    var name: String
    var image: String
    var pid: String
    var subtitle: String
    var total = 0
    var price = 0
    var quantity = 0
}
