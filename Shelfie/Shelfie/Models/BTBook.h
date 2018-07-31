//
//  Book.h
//  Shelfie
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <JSONModel/JSONModel.h>

@interface BTBook : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *isbn;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSURL *coverURL;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;




@end
