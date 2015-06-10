//
//  HttpHelp.swift
//  AdView
//
//  Created by DavidWu on 2014-09-14.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import Foundation

func HTTPsendRequest(request: NSMutableURLRequest, callback: (String, String?) -> Void) {
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if error != nil {
                callback("", error.localizedDescription)
            } else {
                callback(NSString(data: data,
                    encoding: NSUTF8StringEncoding)! as String, nil)
            }
    }
    
    task.resume()
}