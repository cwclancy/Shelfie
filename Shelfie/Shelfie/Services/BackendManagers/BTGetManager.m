//
//  BTGetManager.m
//  Shelfie
//
//  Created by Connor Clancy on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTGetManager.h"
#import <Parse/Parse.h>

@implementation BTGetManager
+ (instancetype)shared {
    static BTGetManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)fetchUsersBooksWithUserId:(NSString *)userId completion:(void(^)(NSArray *books, NSError *error))completion {
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" equalTo:userId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
        } else {
            completion(objects, nil);
        }
    }];
}

- (void)fetchBooksWithCompletion:(void(^)(NSArray *books, NSError *error))completion {
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
        } else {
            completion(objects, nil);
        }
    }];
}
@end
