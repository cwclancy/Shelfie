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

- (void) FBUserExists: (FBUser *) user loginController: (BTLoginViewController *) loginVC;

- (BTUser *) getCurrentUser;
- (void) setUser: (BTUser *) user;

- (void)addToBooksHave:(NSString *)bookISBN;
- (void)getBooksHave;
- (void)getBooksRequested;

- (void)removeFromBooksHave:(NSString *)coverURL;
- (void)addToBooksWant:(NSString *)coverURL;
- (void)removeFromBooksWant:(NSString *)coverURL;
- (void)getBooksHaveWithCompletion:(void(^)(NSArray *books, NSError *error))completion;
- (void)getBooksWantWithCompletion:(void(^)(NSArray *books, NSError *error))completion;
@end
