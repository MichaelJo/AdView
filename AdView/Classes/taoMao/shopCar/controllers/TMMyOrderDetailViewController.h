//
//  TMMyOrderDetailViewController.h
//  TaoMao
//
//  Created by Alex Song on 14-4-23.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKViewController.h"

@interface TMMyOrderDetailViewController : LTKViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView                      *view_bar;
    UITableView                 *_tableView;
    int                 selectCount;
    UIImageView * imgv_arrow;
}
@end

