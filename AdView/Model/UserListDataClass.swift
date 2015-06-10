//
//  AdListDataClass.swift
//  AdView
//
//  Created by DavidWu on 2014-08-15.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import Foundation
import UIKit

class UserListDataClass {
    
    var Name: String
    var Account: String
    var Password: String
    
    init(){
	    
        Name = ""		
		Account = ""
        Password = ""
    }
}

var UserIdx = 0 //The used account
var UserAry = [UserListDataClass]() //Account list
var UserState = ""

let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
var UserViewDataIdx = 0
var UserViewDataAct = ""

var UserViewDataName = ""
var UserViewDataAccount = ""
var UserViewDataPassword = ""
var UserViewDataButton = ""

var UserViewDataResult = 0

var AdModeShrink = 1
//var AdModeGoNext = 0

