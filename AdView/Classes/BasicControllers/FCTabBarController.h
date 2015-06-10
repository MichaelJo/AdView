//
//  FCTabBarController.h
//  fc
//
//  Created by Alex Song on 15-1-17.
//  Copyright (c) 2015 Aditmax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"
#import "ZSYPopoverListView.h"


@protocol FCTabBarDelegate <NSObject>

-(BOOL)tabBarArrowHidden:(BOOL)hidden;

@end
@interface FCTabBarController : CustomTabBar<ZSYPopoverListDatasource,ZSYPopoverListDelegate,UITabBarControllerDelegate,FCTabBarDelegate,UITabBarDelegate>
{
    NSArray                     *  room_count;
    NSString                    *room_name;
    NSString                    *room_id;
    NSString                    *student_id;
    bool                    itmeSelect;
    Reachability *hostRech;

}

@property (nonatomic, retain) UIImageView                   * tabBarArrow;
@property(nonatomic,retain)NSMutableArray       *daoHangArray;

@end
