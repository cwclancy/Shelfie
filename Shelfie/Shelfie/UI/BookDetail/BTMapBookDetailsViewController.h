//
//  BTMapBookDetailsViewController.h
//  Shelfie
//
//  Created by Connor Clancy on 8/2/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBook.h"
#import "BTBookBaseViewController.h"

@interface BTMapBookDetailsViewController : BTBookBaseViewController
@property (strong, nonatomic) BTBook *book;
@end
