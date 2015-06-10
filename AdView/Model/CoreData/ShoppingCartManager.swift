//
//  ShoppingCartManager.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-02.
//  Copyright (c) 2015 AditMax. All rights reserved.
//
import Foundation
import UIKit
@objc protocol ShoppingCartManagerDelegate{
    func listLoaded(error: String?, items:[CartItem])
    func pointsLoaded(error: String?)
}
@objc class ShoppingCartManager {
    var items: [CartItem] = []
    var delegate:ShoppingCartManagerDelegate! = nil
    let ServerUrlHttps = "https://aditstudio.com/view/mob/ads/"
    
    init(){
        
        /*request(.GET, "http://aditplanet.com/api/v1/deals/promo", parameters: ["foo": "bar"])
            .responseSwiftyJSON { (request, response, json, error) in
                println("shopping cart manager init")
                println(json["data"][0]["terms"])
                //println(error)
                //   var item = json["0"] as NSDictionary
                //    println(item)
        }*/
        
    }
    func updateItemQuantity(dealId: String, newValue: String){
        var url = "http://aditplanet.com/api/v1/cart/client/0083532/session/10b4b5daab166b70c91e/update/\(dealId)/quantity/\(newValue)"
        println(url)
        request(.PUT, url).responseSwiftyJSON { (request, response, json, error) in
            if(error != nil) {
                println(error)
            }else{
                //println(json)
              
            }
        }
        
    }
    func insertItem(dealId: String, newValue: String){
        var url = "http://aditplanet.com/api/v1/cart/client/0083532/session/10b4b5daab166b70c91e/insert/\(dealId)/quantity/\(newValue)"
        println(url)
        request(.POST, url).responseSwiftyJSON { (request, response, json, error) in
            if(error != nil) {
                println(error)
            }else{
                println(json)
                
                if let info = json["info"].string{
                    if(info == "Row exists! Use the update call"){
                        self.updateItemQuantity(dealId, newValue: newValue)
                    }
                }else{
                    
                }
                self.get()
                NSNotificationCenter.defaultCenter().postNotificationName("InsertedOrUpdatedAnDeal", object: nil)
            }
        }
    }
    func deleteItem(dealId: String){
        //http://aditplanet.com/api/v1/cart/client/0083532/session/10b4b5daab166b70c91e/deal/74
        var url = "http://aditplanet.com/api/v1/cart/client/0083532/session/10b4b5daab166b70c91e/deal/\(dealId)"
        println(url)
        request(.DELETE, url).responseSwiftyJSON { (request, response, json, error) in
            if(error != nil) {
                println(error)
            }else{
                println(json)
                
                if let result = json["result"].string{
                    if(result == "success"){
                        //self.updateItemQuantity(dealId, newValue: newValue){"result":"success"}
                        self.get()
                        //NSNotificationCenter.defaultCenter().postNotificationName("InsertedOrUpdatedAnDeal", object: nil)
                    }
                }else{
                    
                }
            }
        }
    }
    func getPoints(){
        request(.GET, ServerUrlHttps + "points/", parameters: ["foo": "bar"])
            .responseSwiftyJSON { (request, response, json, error) in
                if(error == nil) {
                    var total = 1
                    var prefs = AdPreferences.sharedInstance()
                    if let adPoints = json["adpoints"].int{
                        prefs.cartGrandTotal = total
                    }else{
                        prefs.cartGrandTotal = 0
                    }
                    if(self.delegate != nil){
                        self.delegate.pointsLoaded(nil)
                    }
                }
                else{
                    if(self.delegate != nil){
                        self.delegate.pointsLoaded("Error: \(error)")
                    }
                }
        }
    }

    func get(){
        
        //var items:[CartItem] = []
        request(.GET, "http://aditplanet.com/api/v1/cart/client/0083532/session/10b4b5daab166b70c91e", parameters: ["foo": "bar"])
            .responseSwiftyJSON { (request, response, json, error) in
                //       println("shopping cart manager init")
                //       println(json["data"][0]["terms"])
                if(error == nil) {
                    
                    var prefs = AdPreferences.sharedInstance()
                    
                    var item = CartItem()
                    if let total = json["grand_total"].int{
                        prefs.cartGrandTotal = total
                    }else{
                        prefs.cartGrandTotal = 0
                    }
                    if(json["data"].count > 1)
                    {
                        if let id = json["data"][0]["client_id"].string{
                            prefs.clientId = id
                        }else{
                            prefs.clientId = ""
                        }
                    }
                    prefs.cartItemDealIdArray = []
                    prefs.cartItemIdArray = []
                    prefs.cartItemQuantityArray = []
                    prefs.cartItemAdpointsArray = []
                    
                    var emptyValue = "0"
                    if(json["data"].count == 0)
                    {
                        self.delegate.listLoaded(nil,items: self.items)
                        return
                    }
                    for index in 0...json["data"].count-1{
                        //var item = CartItem()
                        if let deal_id = json["data"][index]["deal_id"].string{
                            prefs.cartItemDealIdArray.append(deal_id)
                        }else{
                            prefs.cartItemDealIdArray.append(emptyValue)
                        }
                        if let id = json["data"][index]["id"].string{
                            
                            prefs.cartItemIdArray.append(id)
                        }else
                        {
                            prefs.cartItemIdArray.append(emptyValue)
                        }
                        //item.pid = json["data"][index]["id"].string!
                        
                        if let quantity = json["data"][index]["quantity"].string{
                            prefs.cartItemQuantityArray.append(quantity)
                        }else{
                            prefs.cartItemQuantityArray.append(emptyValue)
                        }
                        var p = emptyValue
                        if let adpoints = json["data"][index]["adpoints"].string{
                            println(adpoints)
                            var pointsArr = split(adpoints){$0 == "."}
                            if(pointsArr.count > 0){
                                p = pointsArr[0]
                            }
                            
                            prefs.cartItemAdpointsArray.append(p)
                        }else{
                            prefs.cartItemAdpointsArray.append(emptyValue)
                        }
                        //self.items.append(item)
                        //println(item.name)
                        
                    }
                    //println(self.items)
                    if(self.delegate != nil){
                    self.delegate.listLoaded(nil,items: self.items)
                    }
                }
                else{
                    if(self.delegate != nil){
self.delegate.listLoaded("Error: \(error)",items: self.items)
                    }
                }
        }
        //println(error)
        //   var item = json["0"] as NSDictionary
        //    println(item)
    }
    
}


