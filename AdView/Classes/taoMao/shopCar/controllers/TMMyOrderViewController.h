//
//  TMMyOrderViewController.h
//  TaoMao
//
//  Created by Alex Song on 14-4-23.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKViewController.h"

@interface TMMyOrderViewController : LTKViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *view_bar;
    UIButton*BtnItem1,*BtnItem2;
    UIImageView *tabBarArrow;
    UITableView*_tableView;
}
@end
