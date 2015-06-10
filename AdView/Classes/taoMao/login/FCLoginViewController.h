//
//  FCLoginViewController.h
//  Flower&Cake
//
//  Created by Alex Song on 13-7-14.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKViewController.h"

@interface FCLoginViewController : LTKViewController<UITextFieldDelegate>
{

    UIView *view_bar;
    UITextField *fieldName,*fieldPsw;
}
@end
