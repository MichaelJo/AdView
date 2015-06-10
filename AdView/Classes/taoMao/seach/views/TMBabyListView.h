//
//  TMBabyListView.h
//  TaoMao
//
//  Created by Alex Song on 14-4-25.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMBabyListView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrContent;
    int firstViewSelectTag;
    //一级分数数据
    NSMutableArray *_categoryNameList;
    NSMutableArray*_AreaList;
    //    NSMutableArray*_shopInfoTypeList;
    int selectTag;
    UIImageView * slideBg;
}

@end
