//
//  ServerManager.swift
//  AdViewer
//
//  Created by Alex Song Pro Li on 2015-01-18.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
import UIKit

protocol ServerManagerDelegate{
    //func loggedIn()
    func loginFailed(error: String)
    //func userCreated(username: String)
    func ratingSubmitted(error: String, adsViewed: Int)
    func adsListLoaded(error: String, adsViewed: Int)
}
class ServerManager{
    let mgr: Manager
//    let domainName = "127.0.0.1:6548"
    let domainName = "aditstudio.com"

//    let ServerUrl = "http://aditstudio.com/ad/mob/"
//    let ServerUrlHttps = "http://aditstudio.com/ad/mob/"
    let ServerUrl:String
    let ServerRoot:String
    let ServerRootHttps:String
    //    let ServerUrl = "http://aditmax.com"
    //    let ServerUrlHttps = "https://aditmax.com"
    let ServerUrlHttps:String
    
    var delegate:ServerManagerDelegate! = nil
    init(){
        mgr = Manager(configuration: cfg)
        self.ServerUrl = "http://\(domainName)/ad/mob/"
        self.ServerRoot = "http://\(domainName)/"
        self.ServerRootHttps = "https://\(domainName)/"

        //    let ServerUrl = "http://aditmax.com"
        //    let ServerUrlHttps = "https://aditmax.com"
        self.ServerUrlHttps = "http://\(domainName)/ad/mob/"
    }
    func login()
    {
        //todo: will refactor this later
        UserAccountSetting().UserListDataSysPut()
        if UserIdx == 0 {
            UserState = "None"
            return
        }
        
        let acc = UserAry[UserIdx].Account
        let pass = UserAry[UserIdx].Password
        login(acc,password: pass)
    }
    
    func register(username: String, password: String, email: String){
        var urlPath = ServerUrlHttps + "reg/"
        
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        mgr.session.configuration.HTTPAdditionalHeaders = ["Authorization": "Basic " + base64LoginString]
        mgr.request(.POST, urlPath,parameters:["email":email]).responseJSON { (request, response, data, error) in
            if(error != nil) {
                self.delegate.loginFailed(error!.localizedDescription)
            }
            else
            {
                var error_string = "unknown error, please wait and try again."
                if let data_c: AnyObject = data{
                    if let u_status = data_c["status"] as! String?{
                        println(u_status)
                        if(u_status == "0"){
                            //self.setAdsList()
                            error_string = ""
                            UserState = "logged in"
                            if let u_name = data_c["user_name"] as! String?{
                                let user_name = u_name
                                println(user_name)
                                //self.delegate.userCreated(user_name)
                            //NSNotificationCenter.defaultCenter().postNotificationName("userCreated", object: nil)
                                NSNotificationCenter.defaultCenter().postNotificationName("userCreated", object: nil, userInfo: ["user_name":user_name])
                            }
                        }else{
                            error_string = "Please check your account and password."
                            NSNotificationCenter.defaultCenter().postNotificationName("userCreatingFailed", object: nil,userInfo:["error":error_string])
                        }
                    }
                }
                if ("" != error_string){
                    self.delegate.loginFailed(error_string)
                    NSNotificationCenter.defaultCenter().postNotificationName("userCreatingFailed", object: nil,userInfo:["error":error_string])
                    
                }
            }
        }
    }
    
    
    func login(username: String, password: String){
        var urlPath = ServerUrlHttps + "login/"
        
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        mgr.session.configuration.HTTPAdditionalHeaders = ["Authorization": "Basic " + base64LoginString]
        
        mgr.request(.POST, urlPath).responseJSON { (request, response, data, error) in
                if(error != nil) {
//                    self.delegate.loginFailed(error!.localizedDescription)
                    var userinfo = ["error":"Networking error\(urlPath)\(error!.localizedDescription)","status":"1"]
                    NSNotificationCenter.defaultCenter().postNotificationName("userLogging", object: nil,userInfo: userinfo)
                }
                else
                {
                    var error_string = "unknown error, please wait and try again."
                    if let data_c: AnyObject = data{
                        if let u_status = data_c["status"] as! String?{
                            if(u_status == "0"){
                                self.setAdsList()
                                
                                if let u_name = data_c["username"] as! String?{
                                    if(u_name == username)
                                    {
                                        error_string = ""
                                        UserState = "logged in"

                                    }
                                }
                            }else{
                                error_string = "Please check your account and password."
                            }
                        }
                    }
                    if ("" == error_string){
//                        self.delegate.loginFailed(error_string)
                        NSNotificationCenter.defaultCenter().postNotificationName("userLogging", object: nil,userInfo:["user":username,"status":"0"])
                    }else
                    {
                        NSNotificationCenter.defaultCenter().postNotificationName("userLogging", object: nil,userInfo:["error":error_string,"status":"1"])
                    }
                    
                    
                }
        }
    }
        func checkLoginStatus(){
            
        }
        func rate(adId : String, adRate : Int, startDateString : String){
            let date = NSDate()
            let formatter = NSDateFormatter()
            var error_message = ""
            var count : Int = 0
            formatter.dateFormat = "HH:mm:ss"
            formatter.timeZone = NSTimeZone(name: "America/Vancouver")
            var endDateString = formatter.stringFromDate(date)
            var url = ServerRoot + "/ajax/save/rate/0/\(adId)/\(adRate)/\(startDateString)/\(endDateString)/"
            mgr.request(.POST, url)
                .responseJSON { (request, response, data, error) in
                    if(error != nil) {
                        //println("Error: \(error)")
                        //println(request)
                        //println(response)
                        //self.loading.text = "Internet appears down!"
                        error_message = error!.localizedDescription
                        self.delegate.ratingSubmitted(error_message,adsViewed: 0);

                    }
                    else {
                        println("Success: \(url)")
                        println(request)
                        //var json = JSON(json!)
                        //self.updateUISuccess(json)
                        println(response)
                        println(data)
                        if let data_c: NSDictionary = data as? NSDictionary{
                            println(data_c)
                            //if (data_c.ContainsKey("ads_viewed_count")){
                            let ads_viewed = data_c["ads_viewed_count"] as? Int
                            if (ads_viewed != nil){
                                count = ads_viewed!
                                println(count)
                                self.delegate.ratingSubmitted("",adsViewed: count);
                            }
                        
                            if (count <= 0){
                                if let error_string = data_c["error"] as! String?{
                                    error_message = error_string
                                    self.delegate.ratingSubmitted(error_message,adsViewed:0);
                                }
                                //                        return (error_message,count)
                                
                            }
                            //println(error_message)
                            //println(count)
                        }
                        

                    }
                    
                    
            }
        }
        func setAdsList(){
            var adsList :NSArray = []
            var error_message = ""
            var count = 0
            let url = ServerUrlHttps + "ads/flow/"
            println(url)
            mgr.request(.GET, url)
                .responseJSON { (request, response, data, error) in
                    if(error != nil) {
                        error_message = error!.localizedDescription
                        println(error_message)
                        //                    self.delegate.adsListLoaded(error_message,adsViewed: count)
                    }
                    else{
                        println(data)
                        if let data_c: AnyObject = data{
                            println(data_c["ads"]!)
                            println(data_c["total_viewed"]!)
                            
                            let json_ary0 = data_c["ads"] as? NSArray
                            if (json_ary0 == nil){
                                println("Task json_ary=nil")
                                return
                            }
                            //AdsViewed = UInt(data_c["total_viewed"]!)
                            if let adsViewedNum = data_c["total_viewed"] as? Int{
                                count = adsViewedNum
                            }
                            adsList = json_ary0!
                            println("Task json count=\(adsList.count)")
                            var json_cnt = adsList.count
                            if json_cnt > 100 {
                                json_cnt = 100
                            }
                            CellAry.removeAll(keepCapacity: false)
                            //json_cnt = 10
                            if ( CellAry.count == 0 ){
                                for var i = 0 ; i<json_cnt ; ++i {
                                    //var cell = AdListDataClass()
                                    CellAry.append(AdListDataClass())
                                }
                            }
                            if ( json_cnt > CellAry.count ){
                                json_cnt = CellAry.count
                            }
                            for var i = 0; i < json_cnt; ++i {
                                let ary = adsList[i] as! NSArray
                                let id = ary[0] as! Int
                                let thumbshort = ary[1] as! String
                                let thumb = self.ServerRoot + "static/uploads/thumb/\(thumbshort)"
                                println(thumb)
                                let url = self.ServerRoot + "view/ads_v2/detail/\(id)"
                                CellAry[i].UrlSet(AdId: id, AdUrl: url, Thumb:thumb)
                            }
                        }
                        println("count -- p:\(count)")
                        self.delegate.adsListLoaded(error_message,adsViewed: count)
                       
                    }

                    
            }
            //return adsList
        }
}
