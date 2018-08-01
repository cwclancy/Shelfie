//
//  BTFbAPIManager.m
//  Shelfie
//
//  Created by Chaliana Rolon on 7/30/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTFbAPIManager.h"
#import "BTUserManager.h"

@implementation BTFbAPIManager

+ (instancetype) shared {
    static BTFbAPIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype) init {
    
    return self;
}

// Login or Logout the current user respectively
- (void) login: (BTLoginViewController *) loginController {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    // Logout
    if([FBSDKAccessToken currentAccessTokenIsActive]) {
        [login logOut];
        NSLog(@"Logout");
    } else {
        //Login
        [login logInWithReadPermissions : @[@"public_profile"] fromViewController:loginController handler:^(FBSDKLoginManagerLoginResult *result , NSError *error ) {
            if ( error ) {
                NSLog (@"Process error" );
            } else if ( result . isCancelled ) {
                NSLog (@ "Canceled" );
            } else {
                NSLog (@"Logged in" );
                [self fetchFBSDKUserData];
            }
        }];
    }
}

- (void) fetchFBSDKUserData {
    // If user logged in successfully, fetch data from facebook
    if ([FBSDKAccessToken currentAccessToken ]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, picture"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) { // Initiate FBUser using JSONModel
                 NSLog(@"User dictionary after log in:%@", result);
                 // getFBUser pass on FBUser to User manager
                 FBUser *fbUser = [[FBUser alloc] initWithDictionary:result error:nil];
                 [[BTUserManager shared] FBUserExists:fbUser];
             }
         }];
        
    }
    
}


@end
