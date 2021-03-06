//
//  GOBook.h
//  Shelfie
//
//  Created by Connor Clancy on 7/30/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface GOBook : JSONModel
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *authors;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSDictionary *imageLinks;
@end
