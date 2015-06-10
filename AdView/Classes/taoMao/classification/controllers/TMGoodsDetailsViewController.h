//
//  TMGoodsDetailsViewController.h
//  TaoMao
//
//  Created by Alex Song on 14-4-17.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKViewController.h"
#import <UIKit/UIKit.h>
//#import "TMDetailView.h"
#import "UrlImageButton.h"


@interface TMGoodsDetailsViewController : LTKViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView*  tabBarArrow;//上部桔红线条
    UIButton*BtnItem1; //上部三个按钮
    UIButton*BtnItem2;
    UIButton*BtnItem3;
    
    UrlImageButton *_bigView2;
    UrlImageButton *_bigImg;

    UrlImageButton *btnNine;
}
@property (strong, nonatomic) NSString *pid;

@end
