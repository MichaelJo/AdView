//
//  Coupon.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-02-16.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
import CoreData

@objc(Coupon)
class Coupon {
    init(){
        self.link = ""
        self.name = ""
    }
    var link: String
    var name: String
    
}
