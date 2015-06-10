//
//  TMShopStoreViewController.h
//  TaoMao
//
//  Created by Alex Song on 14-4-19.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKViewController.h"

@interface TMShopStoreViewController : LTKViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView                     *_tableView;
    UIView                  *view_bar;
    BOOL                    _isTabbar;
}
-(id)initWithTabbar:(BOOL)isTabbar;
@end
