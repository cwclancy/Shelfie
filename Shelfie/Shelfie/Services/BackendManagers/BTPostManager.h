//
//  BTPostManager.h
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTBook.h"
#import "BTUser.h"

@interface BTPostManager : NSObject
+ (instancetype) shared;
+ (void) addBookToDatabaseWithUserId:(NSString *)userId title:(NSString *)title author:(NSString *)author
                                isbn:(NSString *)isbn date:(NSDate *)date coverURL:(NSURL *)url
                            latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude
                          completion:(PFBooleanResultBlock)completion;

+ (void)addUserToDatabase:(NSString *) userId withName:(NSString *) name withProfilePicture:(NSString *) profilePicture withBooks:(NSMutableArray *) booksHave withWantBooks:(NSMutableArray *) booksWant withSellBooks:(NSMutableArray *) booksSell withTradeBooks:(NSMutableArray *) booksTrade withCompletion:(PFBooleanResultBlock)completion;

@end
