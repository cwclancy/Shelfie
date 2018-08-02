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

+ (nonnull NSString *)parseClassName {
    return @"Book";
}


@end
