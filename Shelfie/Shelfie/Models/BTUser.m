//
//  BTUser.m
//  Shelfie
//
//  Created by Chaliana Rolon on 7/30/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTUser.h"

@implementation BTUser

@dynamic userId;
@dynamic name;
@dynamic picture;
@dynamic booksHave;
@dynamic booksSell;
@dynamic booksWant;
@dynamic booksTrade;

+ (nonnull NSString *) parseClassName {
    return @"User";
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.picture forKey:@"picture"];
    [aCoder encodeObject:self.booksTrade forKey:@"booksTrade"];
    [aCoder encodeObject:self.booksHave forKey:@"booksHave"];
    [aCoder encodeObject:self.booksWant forKey:@"booksWant"];
    [aCoder encodeObject:self.booksSell forKey:@"booksSell"];
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
