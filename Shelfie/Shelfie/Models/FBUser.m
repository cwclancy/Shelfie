//
//  FBUser.m
//  Shelfie
//
//  Created by Chaliana Rolon on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "FBUser.h"

@implementation FBUser

+ (JSONKeyMapper *) keyMapper {
    // Map Keys respectively
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary: @{
              @"userId": @"id",
              @"name": @"name",
              @"picture": @"picture.data.url"
        }];
}

@end
