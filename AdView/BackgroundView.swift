//
//  BkgdView.swift
//  AdView
//
//  Created by DavidWu on 2014-10-25.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView: UIView {
    
    //override init(){
    //    super.init();
        
    //}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let space: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()
        let colors: CFArray = [
            UIColor(red: 8/255.0, green: 207/255.0, blue: 247/255.0, alpha: 1).CGColor,
            UIColor(red: 69/255.0, green: 94/255.0, blue: 217/255.0, alpha: 1).CGColor
        ]
        let locations: [CGFloat] = [0, 1]
        
        let gradient = CGGradientCreateWithColors(space, colors, locations)
        
        let currentContext = UIGraphicsGetCurrentContext()
        let startPoint = CGPointZero
        let endPoint = CGPointMake(frame.width, frame.height)
        
        CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0)
    }
    
}