//
//  Super.h
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-01.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Super : NSManagedObject

@property (nonatomic, retain) NSNumber * syncStatus;
@property (nonatomic, retain) NSNumber * adpoints;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * deal_price_note;
@property (nonatomic, retain) NSString * hot_deal;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * images;
@property (nonatomic, retain) NSString * initial_price_note;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * merchant_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * terms;
@property (nonatomic, retain) NSDate * end_date;
@property (nonatomic, retain) NSDate * hot_end;
@property (nonatomic, retain) NSDate * hot_start;
@property (nonatomic, retain) NSDate * start_date;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSDate * valit_end;
@property (nonatomic, retain) NSDate * valit_start;

@end
