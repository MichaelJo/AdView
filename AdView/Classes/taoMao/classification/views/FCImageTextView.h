//
//  JUMapView.h
//  
//
//  Created by on 13-5-7.
//  Copyright (c) 2015  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCImageTextView : UIScrollView<UIScrollViewDelegate>
{

    UrlImageView *imageView;

}
@property (nonatomic, retain) UrlImageView *imageView;

@end
