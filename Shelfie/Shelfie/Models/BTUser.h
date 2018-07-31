//
//  BTUser.h
//  Shelfie
//
//  Created by Chaliana Rolon on 7/30/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "PFObject.h"
#import <Parse/Parse.h>
#import <JSONModel/JSONModel.h>

@interface BTUser : PFObject <NSCoding, PFSubclassing>

// USER PROPERTIES
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *picture;
@property (strong, nonatomic) NSMutableArray *booksHave;
@property (strong, nonatomic) NSMutableArray *booksWant;
@property (strong, nonatomic) NSMutableArray *booksSell;
@property (strong, nonatomic) NSMutableArray *booksTrade;

// USER METHODS
- (void) addToBooksHave;
- (void) addToBooksWant;
- (void) removeFromBooksHave;
- (void) removeFromBooksWant;

@end
