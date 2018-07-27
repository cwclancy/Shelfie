//
//  BTBookAPIManager.m
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTBookAPIManager.h"
#import <Parse/Parse.h>

@implementation BTBookAPIManager

+ (instancetype)shared {
    static BTBookAPIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

+ (void)fetchUsersBooksWithUserId:(NSString *)userId completion:(void(^)(NSArray *books, NSError *error))completion {
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

+ (void)fetchUsersBooksWithCompletion:(void(^)(NSArray *books, NSError *error))completion {
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
