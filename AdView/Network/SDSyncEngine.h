//
//  SDSyncEngine.h
//  SignificantDates
//
//  Created by Chris Wagner on 7/1/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SDCoreDataController.h"

typedef enum {
    SDObjectSynced = 0,
    SDObjectCreated,
    SDObjectDeleted,
} SDObjectSyncStatus;

@interface SDSyncEngine : NSObject

@property (atomic, readonly) BOOL syncInProgress;

+ (SDSyncEngine *)sharedEngine;

- (void)registerNSManagedObjectClassToSync:(Class)aClass;
- (void)startSync;
- (void)saveContext;

- (NSManagedObjectContext*)managedObjectContext;

- (NSString *)dateStringForAPIUsingDate:(NSDate *)date;

@end
