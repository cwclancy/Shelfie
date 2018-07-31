//
//  Book.m
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTBook.h"

@implementation BTBook

@synthesize userId;
@synthesize title;
@synthesize author;
@synthesize isbn;
@synthesize date;
@synthesize coverURL;
@synthesize latitude;
@synthesize longitude;

+ (nonnull NSString *)parseClassName {
    return @"Book";
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.isbn = [aDecoder decodeObjectForKey:@"isbn"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.coverURL = [aDecoder decodeObjectForKey:@"converURL"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:userId forKey:@"userId"];
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:author forKey:@"author"];
    [aCoder encodeObject:isbn forKey:@"isbn"];
    [aCoder encodeObject:date forKey:@"date"];
    [aCoder encodeObject:coverURL forKey:@"coverURL"];
    [aCoder encodeObject:latitude forKey:@"latitude"];
    [aCoder encodeObject:longitude forKey:@"longitude"];
}




@end
