//
//  AdPagerViewController.m
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-07.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "AdPagerViewController.h"
#import "TMThirdClassViewController.h"
@interface AdPagerViewController ()<NKJPagerViewDataSource, NKJPagerViewDelegate>

@end

@implementation AdPagerViewController

- (void)viewDidLoad
{
    
    self.dataSource = self;
    self.delegate = self;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - NKJPagerViewDataSource

- (NSUInteger)numberOfTabView
{
    return 3;
}

- (UIView *)viewPager:(NKJPagerViewController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    
    CGFloat r = (arc4random_uniform(255) + 1) / 255.0;
    CGFloat g = (arc4random_uniform(255) + 1) / 255.0;
    CGFloat b = (arc4random_uniform(255) + 1) / 255.0;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    label.backgroundColor = color;
    
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [NSString stringWithFormat:@"Tab #%lu", index * 10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
    return label;
}

- (UIViewController *)viewPager:(NKJPagerViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AdListViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    vc.textLabel = [NSString stringWithFormat:@"Content View #%lu", index];
    return vc;*/
    TMThirdClassViewController*vc = [[TMThirdClassViewController alloc] initWithTopbar:false];
    return vc;
}

- (NSInteger)widthOfTabView
{
    return 160;
}

#pragma mark - NKJPagerViewDelegate

- (void)viewPager:(NKJPagerViewController *)viewPager didSwitchAtIndex:(NSInteger)index withTabs:(NSArray *)tabs
{
    [UIView animateWithDuration:0.1
                     animations:^{
                         for (UIView *view in self.tabs) {
                             if (index == view.tag) {
                                 view.alpha = 1.0;
                             } else {
                                 view.alpha = 0.5;
                             }
                         }
                     }
                     completion:^(BOOL finished){}];
}

@end