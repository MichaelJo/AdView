//
//  AdPreferences.h
//  AdViewer
//
//  Created by Alex Li Song on 2015-03-04.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "PAPreferences.h"

// Ensure we get an error if we forget to add @dynamic for each property
#pragma clang diagnostic push
#pragma clang diagnostic error "-Wobjc-missing-property-synthesis"

@interface AdPreferences : PAPreferences

@property (nonatomic, assign) BOOL hasSeenIntro;
@property (nonatomic, assign) NSInteger pressCount;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSArray *cartItemIdArray;
@property (nonatomic, assign) NSArray *cartItemDealIdArray;
@property (nonatomic, assign) NSArray *cartItemQuantityArray;
@property (nonatomic, assign) NSArray *cartItemAdpointsArray;
@property (nonatomic, assign) NSString *clientId;
@property (nonatomic, assign) NSString *sessionId;
@property (nonatomic, assign) NSString *cartId;
@property (nonatomic, assign) NSInteger cartGrandTotal;
@property (nonatomic, assign) NSArray *popProductIdArray;
//@property (nonatomic, assign) NSArray *newProductIdArray;
@property (nonatomic, assign) NSArray *superProductIdArray;

@end

#pragma clang diagnostic pop