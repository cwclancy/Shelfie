//
//  BTUser.m
//  Shelfie
//
//  Created by Chaliana Rolon on 7/30/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTUser.h"

@implementation BTUser

@synthesize userId;
@synthesize name;
@synthesize picture;
@synthesize booksHave;
@synthesize booksSell;
@synthesize booksWant;
@synthesize booksTrade;

+ (nonnull NSString *) parseClassName {
    return @"User";
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:userId forKey:@"userId"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:picture forKey:@"picture"];
    [aCoder encodeObject:booksTrade forKey:@"booksTrade"];
    [aCoder encodeObject:booksHave forKey:@"booksHave"];
    [aCoder encodeObject:booksWant forKey:@"booksWant"];
    [aCoder encodeObject:booksSell forKey:@"booksSell"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.picture = [aDecoder decodeObjectForKey:@"picture"];
        self.booksTrade = [aDecoder decodeObjectForKey:@"booksTrade"];
        self.booksSell = [aDecoder decodeObjectForKey:@"booksSell"];
        self.booksWant = [aDecoder decodeObjectForKey:@"booksWant"];
        self.booksHave = [aDecoder decodeObjectForKey:@"booksHave"];
    }
    return self;
}


@end
