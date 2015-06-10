//
//  Wechat.swift
//  AdView
//
//  Created by DavidWu on 2014-09-23.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import Foundation

var WxCnt = 0;

func WeChatSendLink(urlStr: String){
    println("WechatSendLink")
    
    if (WxCnt==0){
        
        WXApi.registerApp("wxd69050da08bd1632");
        WxCnt++;
    }
    //[WXApi registerApp:"wxd69050da08bd1632"]
    let message = WXMediaMessage()
    message.title = "Share an ad:";
    message.description = urlStr;
    message.setThumbImage(UIImage(named: "StarOnImage"));
    
    let ext = WXWebpageObject();
    ext.webpageUrl = urlStr;
    
    message.mediaObject = ext;
    
    
    let req0 = SendMessageToWXReq();
    req0.bText = false;
    req0.text = "http://aditmax.com";
    req0.message = message;
    req0.scene = 0; //WXSceneSession;
    WXApi.sendReq(req0);

    //To share to WeChat Moments:
    /*
    
    let req1 = SendMessageToWXReq();
    req1.bText = false;
    req1.message = message;
    req1.scene = 1; //WXScene.WXSceneTimeline;
    WXApi.sendReq(req1);
    */
}
/*
SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
req.bText = NO;
req.message = message;
req.scene = WXSceneSession;
[WXApisendReq:req];
To share to WeChat Moments:

SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
req.bText = NO;
req.message = message;
req.scene = WXSceneTimeline;
[WXApisendReq:req];
*/
