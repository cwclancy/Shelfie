//
//  BTUserManager.m
//  Shelfie
//
//  Created by Chaliana Rolon on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTUserManager.h"

@interface BTUserManager()
@end

@implementation BTUserManager

+ (instancetype) shared {
    static BTUserManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype) init {
    
    return self;
}

- (void) setFBUser: (FBUser *)user {
    NSLog(@"User on UserManager: %@", user);
}

@end
