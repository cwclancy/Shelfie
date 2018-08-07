//
//  BTUserManager.h
//  Shelfie
//
//  Created by Chaliana Rolon on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>
#import "FBUser.h"
#import "BTPostManager.h"
#import "BTLoginViewController.h"

@interface BTUserManager : NSObject

+ (instancetype) shared;

- (void) initUser: (BTLoginViewController *) loginController;
+ (void) getUserWithID: (NSString *) userId user:(void(^)(BTUser * owner))user;
- (void) FBUserExists: (FBUser *) user loginController: (BTLoginViewController *) loginVC;

- (BTUser *) getCurrentUser;
- (void) setUser: (BTUser *) user;

- (void)getBooksHave;
- (void)getBooksRequested;

- (void)addToBooksHave:(BTBook *)book;
- (void)addToBooksRequested:(BTBook *)book;
- (void)removeFromBooksHave:(BTBook *)book;
- (void)addToBooksWant:(BTBook *)book;
- (void)removeFromBooksWant:(BTBook *)book;

@end
