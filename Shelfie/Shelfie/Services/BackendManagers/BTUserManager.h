//
//  BTUserManager.h
//  Shelfie
//
//  Created by Chaliana Rolon on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "FBUser.h"
#import "BTUser.h"

@interface BTUserManager : NSObject

+ (instancetype) shared;

- (void) setFBUser: (FBUser *) user;


@end
