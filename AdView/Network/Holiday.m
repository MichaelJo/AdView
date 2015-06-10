//
//  Holiday.m
//  SignificantDates
//
//  Created by Chris Wagner on 5/15/12.
//

#import "Holiday.h"
#import "NSManagedObject+JSON.h"
#import "SDSyncEngine.h"

@implementation Holiday

@dynamic name;
@dynamic link;
@dynamic objectId;
@dynamic date;
@dynamic observedBy;
@dynamic createdAt;
@dynamic updatedAt;
@dynamic syncStatus;

- (NSDictionary *)JSONToCreateObjectOnServer {
    NSString *jsonString = nil;
    NSDictionary *date = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Date", @"__type",
                          [[SDSyncEngine sharedEngine] dateStringForAPIUsingDate:self.date], @"iso" , nil];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.link, "@link",
                                     nil];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization 
                        dataWithJSONObject:jsonDictionary 
                        options:NSJSONWritingPrettyPrinted 
                        error:&error];
    if (!jsonData) {
        NSLog(@"Error creaing jsonData: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonDictionary;
}

@end
