//
//  UserAccountSetting.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-01-21.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import Foundation
protocol AccountSettingDelegate{
    func UserLoggedIn(error: String)
}
@objc public class UserAccountSetting : NSObject {
    var delegate:AdRateDelegate! = nil
    var UserVer = 0 //The used account
    //private struct UserVer { static var _userver: Int = 0 }
    //---------------------------------------------------------------------------
    func UserListDataAdd(name: String, account: String, password: String){
        if(UserAry.count > 0){
            UserListDataEdit(0,name: name,account: account,password: password)
        }
        let item = UserListDataClass()
        item.Name = name
        item.Account = account
        item.Password = password
        UserAry.append(item)
        UserListDataSysPut()
        //UserAry.insert(item, atIndex : i/3)
    }
    //---------------------------------------------------------------------------
     func UserListDataEdit(idx: Int, name: String, account: String, password: String){
        
        let item = UserAry[idx]
        item.Name = name
        item.Account = account
        item.Password = password
        UserListDataSysPut()
    }
    //---------------------------------------------------------------------------
     func UserListDataDel(idx: Int){
        
        UserAry.removeAtIndex(idx)
        if UserIdx >= UserAry.count {
            UserIdx = 0
        }
        UserListDataSysPut()
        
    }
    //---------------------------------------------------------------------------
    //0118295=abc123456
    //0002927=916916
    //0083532=19873131
     func UserListDataLogin(idx: Int){
        
        UserIdx = idx
        //why calling this function here????
        UserListDataSysPut()
        
        if UserIdx == 0 {
            UserState = "None"
            return
        }
        
        let acc = UserAry[UserIdx].Account
        let pass = UserAry[UserIdx].Password
        var serverManager = ServerManager()
        serverManager.login(acc,password: pass)
    }
    //---------------------------------------------------------------------------
     func UserListDataSysGet(){
        println(" SysGet")
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        /*
        let any_type_ary : AnyObject? = userDefaults.arrayForKey("UserListType")
        if let type_ary = any_type_ary as? [Int] {
            println(" SysGet type=\(type_ary)")
            if (type_ary.count>=2){
                UserVer=type_ary[0];
                UserIdx=type_ary[1];
            }
            
            let any_data_ary : AnyObject? = userDefaults.arrayForKey("UserListData")
            if let data_ary = any_data_ary as? [String] {
                println(" SysGet data=\(data_ary)");
                for var i = 0; i < data_ary.count; i+=3 {
                    let item = UserListDataClass()
                    item.Name = data_ary[i]
                    item.Account = data_ary[i+1]
                    item.Password = data_ary[i+2]
                    if (i==0){
                        item.Name = "Guest";
                        item.Account = "Guest";
                    }
                    UserAry.append(item)
                }
            }
        }*/
        
        UserListDataSysInit()
        
        //UserListDataLogin(UserIdx)
    }
    //---------------------------------------------------------------------------
     func UserListDataSysInit(){
        
        //UserAry.removeAll(keepCapacity: false)
        if (UserAry.count>0){
            return;
        }
        
        println(" SysInit")
        
        //UserVer=1;
        UserIdx=0;
        //UserListDataAdd("Guest", account: "Guest", password: "None")
        
        //UserListDataAdd("Test", "0083532", "19873131")
        //println(" SysInit data=\(UserAry)")
        
    }
    //---------------------------------------------------------------------------
    //?????
     func UserListDataSysPut(){
        println(" SysPut")
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        /*
        var type_ary = [UserVer,UserIdx]
        userDefaults.setObject(type_ary, forKey : "UserListType")
        userDefaults.synchronize()*/
        //UserListDataSysTest();
        
        var data_ary = [String]()
        for (var i=0; i<UserAry.count; i+=1){
            data_ary.append(UserAry[i].Name)
            data_ary.append(UserAry[i].Account)
            data_ary.append(UserAry[i].Password)
        }
        userDefaults.setObject(data_ary, forKey : "UserListData")
        userDefaults.synchronize()
    }
    //---------------------------------------------------------------------------
}