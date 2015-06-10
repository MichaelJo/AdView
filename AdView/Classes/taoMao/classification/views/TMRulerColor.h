//
//  TMRulerColor.h
//  TaoMao
//
//  Created by Alex Song on 14-4-21.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMRulerColor : UIView<UITextFieldDelegate>
{
    UrlImageButton *btnNine;
    UrlImageButton *btnNine1;
    BOOL _isTouch;
    int touchID;
    int touchID1;
}
@property (strong, nonatomic) NSString* productId;

@end
