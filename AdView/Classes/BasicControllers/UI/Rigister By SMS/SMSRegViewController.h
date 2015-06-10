//
//  SMSRegViewController.h
//  AdViewer
//
//  Created by Alex Li Song on 2015-05-07.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKViewController.h"

@interface SMSRegViewController : LTKViewController<UITextFieldDelegate>
{
    
    UIView *view_bar;
    UITextField *fieldName,*fieldPsw;
}
@end
