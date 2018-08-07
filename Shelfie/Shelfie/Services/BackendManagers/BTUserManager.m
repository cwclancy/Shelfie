//
//  BTUserManager.m
//  Shelfie
//
//  Created by Chaliana Rolon on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTUserManager.h"
#import <Parse/Parse.h>
#import "BTLoginViewController.h"

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

- (void) initUser: (BTLoginViewController *) loginController {
    // Initiate User (ONLY WORKS IF USER EXISTS ON PARSE)
    [[self fetchUserQueryFromParse] findObjectsInBackgroundWithBlock:^(NSArray *user, NSError *error) {
        if (user.count == 1) {
            self.currentUser = (BTUser *) user[0];
            [loginController performSegueWithIdentifier:@"loginToHome" sender:loginController];
        }
    }];
}

- (BTUser *) getCurrentUser {
    return  self.currentUser;
}

- (void) setUser: (BTUser *) user {
    self.currentUser = user;
}

- (void) FBUserExists: (FBUser *)user loginController: (BTLoginViewController *) loginVC {
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
                        [self initUser:loginVC];
                    }
                }];
            } else {
                [self initUser:loginVC];
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


- (void)addToBooksHave:(BTBook *)book {
    [self.currentUser addObject:book forKey:@"booksHave"];
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"updated!");
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)removeFromBooksHave:(BTBook *)book {
    [self.currentUser removeObject:book forKey:@"booksHave"];
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"updated!");
        } else {
            NSLog(@"%@", error);
        }
    }];
}

- (void)addToBooksWant:(BTBook *)book {
    [self.currentUser addObject:book forKey:@"booksWant"];
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"updated!");
        } else {
            NSLog(@"%@", error);
        }
    }];
}


- (void)removeFromBooksWant:(BTBook *)book {
    [self.currentUser removeObject:book forKey:@"booksWant"];
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"updated!");
        } else {
            NSLog(@"%@", error);
        }
    }];
}


+ (void) getUserWithID: (NSString *) userId user:(void(^)(BTUser * owner))user {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString: userId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            if(objects.count==1) {
                user(objects[0]);
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


@end
