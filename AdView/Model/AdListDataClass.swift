//
//  AdListDataClass.swift
//  AdView
//
//  Created by DavidWu on 2014-08-15.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import Foundation
import UIKit

let AdListDataDbgName = "AdListData"

class AdListDataClass {
    
    var AdId: Int = 0
    var AdUrl = ""

    var ImgUrl = ""
    var Image: UIImage?
    
    init(){
        
    }
    func UrlSet(AdId id: Int, AdUrl url: String, Thumb thumb:String){
        //NSLog("UrlSet id=\(id)")
        self.AdId = id
        self.AdUrl = url
        
        self.ImgUrl = thumb
        
    }
    //var UIImage
}

var CellAry = [AdListDataClass]()
var CellIdx = 0

func AdListGetUrl(idxOfList: Int) -> String {
    
    if CellAry.count == 0 {
        return "http://aditmax.com"
    }
    var idx = idxOfList
    if (idx >= CellAry.count) {
        idx = 0;
    }
    if (idx < 0){
        idx = CellAry.count-1;
    }
    
    var str = CellAry[idx].AdUrl
    if ( str.hasPrefix("http://") == false ){
        if ( str.hasPrefix("https://") == false ){
            str = "http://\(str)"
        }
    }

    return str
}

func AdListSetIdx(step: Int) {
    
    CellIdx = CellIdx + step
    if (CellIdx >= CellAry.count) {
        CellIdx=0;
    }
    if (CellIdx < 0){
        CellIdx=CellAry.count-1;
    }
}

func AdListPreload() {
    
    
    let url=AdListGetUrl(CellIdx+1)
    let nsurl = NSURL(string: url);
    let ses_cfg = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    let ses = NSURLSession(configuration: ses_cfg)
    
    let task = ses.dataTaskWithURL(nsurl!, completionHandler: { data, response, error in
        println("\(AdListDataDbgName) AdListPreload complete")
        if (error != nil){
            println("Task error:\(error.description)")
            return
        }
        let ses_res = NSString(data: data, encoding: NSUTF8StringEncoding)
        //println(ses_res)
        
        
    })
    task.resume()
    
}


/*func AdListAryGet(){
    let serverManager = ServerManager()
    serverManager.setAdsList()

        //if (json_ses["results"])
    
    
}*/
//http://robots.thoughtbot.com/efficient-json-in-swift-with-functional-concepts-and-generics
//http://www.binpress.com/tutorial/swiftyjson-how-to-handle-json-in-swift/111
//https://medium.com/@santoshrajan/693b3a7bf086

