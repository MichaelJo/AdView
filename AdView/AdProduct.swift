//
//  Product.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-02-19.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
import CoreData
@objc(AdProduct)
class AdProduct {
    init(){
        self.link = ""
        self.name = ""
        self.image = ""
        self.pid = ""
        self.subtitle = ""
        self.terms = ""
        self.adPoints = ""
    }
    var link: String
    var name: String
    var image: String
    var pid: String
    var subtitle: String
    var terms: String
    var adPoints: String
}

