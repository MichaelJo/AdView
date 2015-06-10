//
//  TopCategory.h
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-02.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TopCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * syncStatus;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * images;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updatedAt;

@end
