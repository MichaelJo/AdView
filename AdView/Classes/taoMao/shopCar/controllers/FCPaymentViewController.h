//
//  FCPaymentViewController.h
//  Flower&Cake
//
//  Created by Alex Song on 13-7-13.
//  Copyright (c) 2015 AditMax. All rights reserved.
//


#import "FCShoppingCell.h"
@interface FCPaymentViewController :LTKViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView                 *_tableView;
    NSMutableArray                  *_marrayTitle;
//    UIButton                    *checkBtn;
    NSInteger                   _index;
    BOOL _isPop;
    UIView *view_bar;
}


@end
