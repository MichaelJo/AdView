//
//  TMClassicViewController.h
//  TaoMao
//
//  Created by Alex Song on 14-4-16.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKViewController.h"

@interface TMClassicViewController : LTKViewController<UITableViewDataSource,MJRefreshBaseViewDelegate>
{
    
    MJRefreshHeaderView                 *_header;
    MJRefreshFooterView                 *_footer;
    int                     _page;
    int                    _typeId;
    UIScrollView              *_scrollView;
    NSString               *_isFirst;
    
}

@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSArray *marrayAll;

-(id)initWithWhere:(NSString*)isFirstClass;
@end
