//
//  UserAccountSetting.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-01-21.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: LTKNavigationViewController?

    func startLoading()
    {
        //addToView withLabel:(NSString *)labelText width:(NSUInteger)aLabelWidth;

        DejalBezelActivityView.activityViewForView(self.window)
    }
    
    func stopLoading()
    {
       DejalBezelActivityView.removeViewAnimated(true)
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        SMS_SDK.registerApp("747316812600", withSecret:"86a252172f3f441aeadc8d12843f4fc1")
       // [SMS_SDK registerApp:appKey withSecret:appSecret];
        
        var myp = AdPreferences.sharedInstance()
        println(myp.name)
        //myp.pressCount = 998786
        println(myp.pressCount)
/*        var sm = ServerManager()
        sm.login("11111", password: "1111111")
        var id: AnyObject?
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
        
            
        sm.login("0083532", password: "19873131")
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
        /*NSNotificationCenter
        [[NSNotificationCenter defaultCenter] addObserverForName:@"userCreatingFailed" object:nil queue:nil usingBlock:^(NSNotification *note) {
            NSLog(@"uu:%@",[note.userInfo objectForKey:@"error"]);
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userCreatingFailed" object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userCreated" object:nil];
            
        }];
*/
        
        //sm.register("ttt1", password: "444", email: "122@122.11")
        //myp.name = "your name"
        //var shoppingCart = ShoppingCartManager()
        //shoppingCart.get()
        // Override point for customization after application launch.
		/*
        request(.GET, "http://aditplanet.com/api/v1/deals/promo", parameters: ["foo": "bar"])
            .responseSwiftyJSON { (request, response, json, error) in
                println(json["data"][0]["terms"])
                println(error)
             //   var item = json["0"] as NSDictionary
            //    println(item)
        }*/
        /*
        var context = self.managedObjectContext!
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        newUser.setValue("Alex", forKey: "username")
        newUser.setValue("1234", forKey: "password")
        
        context.save(nil)
        
        var cdrequest = NSFetchRequest(entityName: "Users")
        cdrequest.returnsObjectsAsFaults = false
        
        var results = context.executeFetchRequest(cdrequest, error: nil)
        println(results)
        */
        
        //var cdbase = CoreDataBase()
        /*
        var context = SDSyncEngine.sharedEngine().managedObjectContext()!
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        newUser.setValue("Alex Song", forKey: "username")
        newUser.setValue("1234cc", forKey: "password")
        
        context.save(nil)

        var cdrequest = NSFetchRequest(entityName: "Holiday")
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        
        var results = context.executeFetchRequest(cdrequest, error: &error);
        println(error)
        println(results)
        */
//        SDSyncEngine.sharedEngine().registerNSManagedObjectClassToSync(Holiday)

        /*enable these lines */
        SDSyncEngine.sharedEngine().registerNSManagedObjectClassToSync(Product)
        SDSyncEngine.sharedEngine().registerNSManagedObjectClassToSync(Promo)
        SDSyncEngine.sharedEngine().registerNSManagedObjectClassToSync(Super)
        SDSyncEngine.sharedEngine().registerNSManagedObjectClassToSync(Merchant)
        SDSyncEngine.sharedEngine().registerNSManagedObjectClassToSync(TopCategory)
        SDSyncEngine.sharedEngine().startSync()

        let s1 = NSLocalizedString("HELLO", comment:"")
        
		var  scr = UIScreen.mainScreen()
        var h = scr.bounds.size.height
        var w = scr.bounds.size.width
        NSLog("w=\(w) h=\(h)")
		
        
		//UserListDataSysPut()
       
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        let navbarAppearace = UINavigationBar.appearance()
        // change navigation bar background 
        let barBkgd = UIImage(named: "BarImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .Stretch)
        navbarAppearace.setBackgroundImage(barBkgd, forBarMetrics: UIBarMetrics.Default)
        // change navigation item title color
        navbarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        // change navigation bar item title color
        navbarAppearace.tintColor = UIColor.yellowColor()
        
        var rootView: UIViewController
        
        if (NSUserDefaults.standardUserDefaults().stringForKey("islogin") == "islogin")
        {
          //  rootView = FCRsgisterViewController();
            rootView = FCTabBarController();
         //   rootView = FCLoginViewController();
        }
        else{
            rootView = FCLoginViewController();
            //rootView = FCRsgisterViewController();
            
            //as: only load tabbar for now
            //   rootViewController=[[FCLoginViewController alloc] init];
        }
        //rootView = UserProfileViewController();
        //rootView = RegViewController();
        //rootView = FCLoginViewController();
        
        //let rootView = FCLoginViewController()
        
//        let rootView = FCTabBarController()
        //let view = BoardViewController()//init root
        //let view = FCLoginViewController() //pass
        //let view = TMGoodsDetailsViewController() //pass

        self.navigationController = LTKNavigationViewController(rootViewController: rootView)
        self.window!.rootViewController = self.navigationController
        //self.window!.navigationController.
        
        //init user account
        UserAccountSetting().UserListDataSysGet()


        let cooks = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        cfg.HTTPCookieStorage = cooks
        cfg.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicy.Always
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        var cdbase = CoreDataBase()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        //var context = SDSyncEngine.sharedEngine().managedObjectContext()!
        //context.save(nil)
        //self.saveContext()
        var cdbase = CoreDataBase()
}

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //var context = appDel.managedObjectContext!
     }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //self.saveContext()
        //var context = SDSyncEngine.sharedEngine().managedObjectContext()!
        //context.save(nil)
        //self.saveContext()
        var cdbase = CoreDataBase()
}

    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.hottomali.firstcoredata" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("main", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("main.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict as [NSObject : AnyObject])
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        SDSyncEngine.sharedEngine().saveContext()
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
}
/*
enum UIUserInterfaceIdiom : Int {
    case Unspecified
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}
*/
func isIphone() -> Bool
{
    if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        return true;
    }
    return false;
}
/*
let iOS7 = floor(NSFoundationVersionNumber) <= floor(NSFoundationVersionNumber_iOS_7_1)
let iOS8 = floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_1)
*/