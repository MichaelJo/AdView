//
//  CoreDataBase.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-02-12.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
import CoreData

@objc public class CoreDataBase{
    func getOne(pid:String) -> AdProduct {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        cdrequest.predicate = NSPredicate(format: "id = %@", pid)
        var error: NSError?
        var ret:String! = ""
        var product = AdProduct()
        //println(NSStringFromClass(holiday.class))
        println("getone")

//        var error: NSError?
   var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                println(result.adpoints)
                ret = result.name
                //holiday = result as Holiday
                product.pid = pid
                product.name = result.name
                product.image = result.images
                println(product.image)
                product.subtitle = result.subtitle
                product.terms = result.terms
                product.adPoints = result.adpoints.description
                println(product.adPoints)
            }
    }

        //product.name = "kkk"
        return product
    }
    
    func preSetProductLists(){
        //http://aditplanet.com/api/v1/deals/promo
        
        //http://aditplanet.com/api/v1/deals/super
        var prefs = AdPreferences.sharedInstance()
        prefs.superProductIdArray = []
        prefs.popProductIdArray = []
        //prefs.cartItemQuantityArray = []
        //prefs.cartItemAdpointsArray = []
        
        //var items:[CartItem] = []
        request(.GET, "http://aditplanet.com/api/v1/deals/promo", parameters: ["foo": "bar"])
            .responseSwiftyJSON { (request, response, json, error) in
                if(json["data"].count > 0){
                for index in 0...json["data"].count-1{
                    if let id = json["data"][index]["id"].string{
                        prefs.popProductIdArray.append(id)
                        
                    }
                }
                }
                NSNotificationCenter.defaultCenter().postNotificationName("popProductsUpdated", object: nil)
        }
        request(.GET, "http://aditplanet.com/api/v1/deals/super", parameters: ["foo": "bar"])
            .responseSwiftyJSON { (request, response, json, error) in
                if(json["data"].count > 0){
                    for index in 0...json["data"].count-1{
                    if let id = json["data"][index]["id"].string{
                        prefs.superProductIdArray.append(id)
                    }
                }
                }
                NSNotificationCenter.defaultCenter().postNotificationName("superProductsUpdated", object: nil)
        }
    }
        //println(error)
        //   var item = json["0"] as NSDictionary
        //    println(item)
    func register(username: String, password: String, email: String){
        let sm = ServerManager()
        sm.register(username, password: password, email: email)
    }

    func login(username: String, password: String){
        var sm = ServerManager()
        sm.login(username, password: password)
/*        var id: AnyObject?
        id = NSNotificationCenter.defaultCenter().addObserverForName("userLogging", object: nil, queue: nil) {
            note in
            //let username = note.userInfo?["username"] as! String?{
            //    println(username)
            //}
            if let status = note?.userInfo?["status"] as? String {
                println("Status \(status)")
            }
            
            if let username = note?.userInfo?["user"] as? String {
                println("Received \(username)")
            }
            if let error = note?.userInfo?["error"] as? String {
                println("Error \(error)")
            }
            NSNotificationCenter.defaultCenter().removeObserver(id!)
        }
*/
    }
    
    func getList() -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        //println("hhhh")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }
    func getNormalList() -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        cdrequest.predicate = NSPredicate(format: "(showcase = 0) AND (hot_deal = 0) ")
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        println("normal")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }

    func getPromoList() -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        cdrequest.predicate = NSPredicate(format: "showcase = 1")
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        println("promo")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }
    func getSuperList() -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        cdrequest.predicate = NSPredicate(format: "hot_deal = 1")
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        println("super")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }
    func getListByMerchant(merchantId:String) -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        cdrequest.predicate = NSPredicate(format: "merchant_id = %@", merchantId)
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        //println("hhhh")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                //println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }
   func getDefaultList() -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        cdrequest.sortDescriptors = sortDescriptors
        
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        //println("hhhh")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                //println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }
    
    func getPopList() -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        //println("hhhh")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                //println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }
    func getNewList() -> [AdProduct] {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        var ret:String! = ""
        var products:[AdProduct] = []
        
        //println(NSStringFromClass(holiday.class))
        //println("hhhh")
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                //println(result)
                //println(result)
                ret = result.name
                //holiday = result as Holiday
                var product = AdProduct()
                product.name = result.name
                product.image = result.images
                product.pid = result.id
                products.append(product)
            }
        }
        //println("wwww")
        
        //product.name = "kkk"
        return products
    }

    func clear(){
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var cdrequest = NSFetchRequest(entityName: "Product")
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        var product = AdProduct()
        //println(NSStringFromClass(holiday.class))
        
        //        var error: NSError?
        var results = context.executeFetchRequest(cdrequest, error: &error);
        if (results?.count > 0){
            for result: AnyObject in results!{
                context.deleteObject(result as! NSManagedObject)
            }
        }
            context.save(nil)
    }
    public init(){
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDel.managedObjectContext!
        var engine = SDSyncEngine.sharedEngine()
        var cdrequest = NSFetchRequest(entityName: "TopCategory")
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        
        var results = context.executeFetchRequest(cdrequest, error: &error);
        //println(error)
        //println(results)
        context.save(nil)
        //engine.saveContext()
        if (results?.count > 0){
        for result: AnyObject in results!{
            //println(result)
            //println(result)
        }
        }else{
            println("No results")
        }
        
        //preSetProductLists()
    }
    
}