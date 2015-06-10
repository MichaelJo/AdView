//
//  StoreTableCell.h
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-29.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *DescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ThumbImage;

@end
