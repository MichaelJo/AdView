//
//  MerchantManager.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-09.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
import CoreData

@objc public class MerchantManager: NSObject {
    func getOne(merchantId:String) -> AdMerchant {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Merchant")
        cdrequest.returnsObjectsAsFaults = false
        cdrequest.predicate = NSPredicate(format: "id = %@", merchantId)
        var error: NSError?
        var ret:String! = ""
        var merchant = AdMerchant()
        //println(NSStringFromClass(holiday.class))
        println("getone")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for presult: AnyObject in results!{
                var result = presult as! Merchant
                //println(result)
                //println(result.adpoints)
                ret = result.name
                //holiday = result as Holiday
                merchant.name = result.name
                merchant.imageUrl = result.images
                result.localImageFiles = ""
                //println(product.image)
                merchant.sub_description = result.sub_description
                merchant.terms = result.terms
            }
        }
        //context.save(<#error: NSErrorPointer#>)
        if !context.save(&error) { // 8
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        return merchant
    }
        func getList() -> [AdMerchant] {
            var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            var context = appDel.managedObjectContext!
            var cdrequest = NSFetchRequest(entityName: "Merchant")
            cdrequest.returnsObjectsAsFaults = false
            var error: NSError?
            var ret:String! = ""
            var merchants:[AdMerchant] = []
            
            //println(NSStringFromClass(holiday.class))
            //println("hhhh")
            
            //        var error: NSError?
            var results = context.executeFetchRequest(cdrequest, error: &error);
            println("merchants:\(results?.count)")
            if (results?.count > 0){
                for presult in results!{
                    var result = presult as! Merchant
                    println(result)
                    //println(result)
                    ret = result.name
                    //holiday = result as Holiday
                    var merchant = AdMerchant()
                    merchant.name = result.name
                    var imageArr = split(result.images){$0 == ","}
                    if(imageArr.count > 0){
                        merchant.imageUrl = imageArr[0]
                    }
                    result.localImageFiles = ""
                    //merchant.image = result.images
                    //println(product.image)
                    merchant.sub_description = result.sub_description
                    merchant.terms = result.terms
                    merchant.id = result.id
                    merchants.append(merchant)
                }
            }
            //println("wwww")
            if !context.save(&error) { // 8
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
            //product.name = "kkk"
            return merchants
        }
        
        public override init(){

        }
}
