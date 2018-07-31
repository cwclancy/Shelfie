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

- (void)addUserToDatabase:(NSString *)userId withName:(NSString *) name withProfilePicture:(NSString *)profilePicture withBooks:(NSMutableArray *)booksHave withWantBooks:(NSMutableArray *)booksWant withSellBooks:(NSMutableArray *)booksSell withTradeBooks:(NSMutableArray *)booksTrade withCompletion:(PFBooleanResultBlock)completion {
    BTUser *newUser = [BTUser new];
    newUser.userId = userId;
    newUser.name = name;
    newUser.picture = profilePicture;
    newUser.booksWant = booksWant;
    newUser.booksHave = booksHave;
    newUser.booksSell = booksSell;
    newUser.booksTrade = booksTrade;
    
    [newUser saveInBackgroundWithBlock:completion];
};

- (void) setFBUser: (FBUser *)user {
    NSLog(@"User on UserManager: %@", user);
    [self addUserToDatabase:user.userId withName:user.name withProfilePicture:user.picture withBooks:[NSMutableArray new] withWantBooks:[NSMutableArray new] withSellBooks:[NSMutableArray new] withTradeBooks:[NSMutableArray new] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error) {
            NSLog(@"User added to database");
        }
    }];
}

@end
