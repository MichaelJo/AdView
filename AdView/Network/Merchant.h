//
//  Merchant.h
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-09.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Merchant : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * featured;
@property (nonatomic, retain) NSDate * featured_end_date;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * images;
@property (nonatomic, retain) NSString * map_coordinates;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sub_description;
@property (nonatomic, retain) NSNumber * syncStatus;
@property (nonatomic, retain) NSString * terms;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * www;
@property (nonatomic, retain) NSString * localImageFiles;

@end
