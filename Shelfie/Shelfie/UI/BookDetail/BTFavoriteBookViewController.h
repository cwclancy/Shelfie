//
//  BTFavoriteBookViewController.h
//  Shelfie
//
//  Created by Connor Clancy on 8/9/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBookBaseViewController.h"
#import "BTBook.h"

@interface BTFavoriteBookViewController : BTBookBaseViewController
@property (strong, nonatomic) BTBook *book;
@end
