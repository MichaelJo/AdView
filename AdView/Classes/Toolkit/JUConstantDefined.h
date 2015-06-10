//
//  JUConstantDefined.h
//  
//
//  Created by Alex Song on 15-1-17.
//  Copyright (c) 2015 Aditmax. All rights reserved.
//

// 控制台Log输出控制，此确保在release版本下无Log输出
#ifdef DEBUG
#define JULOG          NSLog
#else
#define JULOG          //WTLLog
#endif

//是否是iPhone5
#define isIPhone5&IPhone5s  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// 自动调整尺寸控制：full形式
#define  AutoresizingFull   UIViewAutoresizingFlexibleLeftMargin|\
UIViewAutoresizingFlexibleWidth|\
UIViewAutoresizingFlexibleRightMargin|\
UIViewAutoresizingFlexibleTopMargin|\
UIViewAutoresizingFlexibleHeight|\
UIViewAutoresizingFlexibleBottomMargin


UIKIT_EXTERN NSString *const kkkk;

