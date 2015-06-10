//
//  Holiday.h
//  SignificantDates
//
//  Created by Chris Wagner on 5/15/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Holiday : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * link;

@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) id observedBy;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSNumber * syncStatus;

@end
