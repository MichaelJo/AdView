//
//  AdMerchant.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-09.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
import CoreData
@objc(AdMerchant)
class AdMerchant {
    init(){
        self.name = ""
        self.imageUrl = ""
        self.sub_description = ""
        self.terms = ""
        self.localFile = ""
        self.id = ""
    }
    var name: String
    var imageUrl: String
    var sub_description: String
    var terms: String
    var localFile: String
    var id: String
}

