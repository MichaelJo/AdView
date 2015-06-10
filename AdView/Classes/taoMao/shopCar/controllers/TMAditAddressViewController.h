//
//  TMAditAddressViewController.h
//  TaoMao
//
//  Created by Alex Song on 14-4-22.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMAditAddressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UIView *view_bar;
    UITableView *_tableView;
    NSInteger _index;
}
@end
