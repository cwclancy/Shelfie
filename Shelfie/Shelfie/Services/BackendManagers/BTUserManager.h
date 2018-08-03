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

- (void) initUser: (BTLoginViewController *) loginControllr;

- (void) FBUserExists: (FBUser *) user loginController: (BTLoginViewController *) loginVC;

- (BTUser *) getCurrentUser;

@end
