//
//  Book.m
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTBook.h"

@implementation BTBook

@dynamic userId;
@dynamic title;
@dynamic author;
@dynamic isbn;
@dynamic date;
@dynamic coverURL;
@dynamic latitude;
@dynamic longitude;
@dynamic sell;
@dynamic trade;
@dynamic gift;
@dynamic location;
@dynamic own;

+ (nonnull NSString *)parseClassName {
    return @"Book";
}

+ (BTBook *) createBookWithUserId:(NSString *)userId title:(NSString *)title author:(NSString *)author
                         isbn:(NSString *)isbn date:(NSString *)date coverURL:(NSString *)coverURL
                     latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude
                          own:(BOOL)own gift:(BOOL)gift trade:(BOOL)trade sell:(BOOL)sell {
    BTBook *res = [BTBook new];
    res.userId = userId;
    res.title = title;
    res.author = author;
    res.isbn = isbn;
    res.date = date;
    res.coverURL = coverURL;
    res.latitude = latitude;
    res.longitude = longitude;
    res.own = own;
    res.gift = gift;
    res.trade = trade;
    res.sell = sell;
    return res;
}

@end
