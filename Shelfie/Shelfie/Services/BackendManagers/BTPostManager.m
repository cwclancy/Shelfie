//
//  BTPostManager.m
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTPostManager.h"

@implementation BTPostManager

+ (id) shared {
    static BTPostManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


- (void) addBookToDatabaseWithUserId:(NSString *)userId title:(NSString *)title author:(NSString *)author
                                isbn:(NSString *)isbn date:(NSString *)date coverURL:(NSURL *)coverURL
                            latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude
                          completion:(PFBooleanResultBlock)completion {
    BTBook *book = [BTBook new];
    book.userId = userId;
    book.title = title;
    book.author = author;
    book.isbn = isbn;
    book.date = date;
    book.coverURL = coverURL;
    book.latitude = latitude;
    book.longitude = longitude;
    [book saveInBackgroundWithBlock:completion];
};


@end
