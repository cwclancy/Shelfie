//
//  BTPostManager.h
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "BTBook.h"

@interface BTPostManager : NSObject

+ (instancetype) shared;
- (void) addBookToDatabaseWithUserId:(NSString *)userId title:(NSString *)title author:(NSString *)author
                                isbn:(NSString *)isbn date:(NSString *)date coverURL:(NSURL *)url
                            latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude
                          completion:(PFBooleanResultBlock)completion;
@end
