//
//  BTUserManager.m
//  Shelfie
//
//  Created by Chaliana Rolon on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTUserManager.h"

@interface BTUserManager()

@property (strong, nonatomic) BTUser *currentUser;

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
    // Initiate User
    [[self fetchUserQueryFromParse] findObjectsInBackgroundWithBlock:^(NSArray *user, NSError *error) {
        self.currentUser = (BTUser *) user[0];
    }];
    return self;
}

- (BTUser *) getCurrentUser {
    return  self.currentUser;
}

- (void) FBUserExists: (FBUser *)user {
    
    // fetch data asynchronously
    [[self fetchUserQueryFromParse] findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            // do something with the array of object returned by the call
            NSLog(@"Successfully retrieved user if any %@", users);
            if(users.count == 0) {
                // Add User to parse
                [BTPostManager addUserToDatabase: user.userId withName: user.name withProfilePicture: user.picture withBooks: [NSMutableArray new] withWantBooks: [NSMutableArray new] withSellBooks: [NSMutableArray new] withTradeBooks: [NSMutableArray new] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        NSLog(@"User added to parse");
                    }
                }];
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (PFQuery *) fetchUserQueryFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:[FBSDKAccessToken currentAccessToken].userID];
    
    return query;
    
}

@end
