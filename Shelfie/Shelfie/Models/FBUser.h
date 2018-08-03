//
//  FBUser.h
//  Shelfie
//
//  Created by Chaliana Rolon on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "JSONModel.h"
#import <JSONModel/JSONModel.h>

@interface FBUser : JSONModel

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *picture;

@end
