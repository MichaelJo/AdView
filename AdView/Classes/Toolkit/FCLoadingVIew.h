//
//  FCLoadingVIew.h
//  Flower&Cake
//
//  Created by Alex Song on 13-7-9.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "LTKView.h"

@interface FCLoadingVIew : LTKView
{

    UIImageView                 *imageView;
}
- (id)initWithFrame:(CGRect)frame addTitle:(NSString*)title;
@end
