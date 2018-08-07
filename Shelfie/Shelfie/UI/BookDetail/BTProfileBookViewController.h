//
//  BTProfileBookViewController.h
//  Shelfie
//
//  Created by Claudia Haddad on 8/3/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBook.h"
#import "BTWhiteRevealViewController.h"

@interface BTProfileBookViewController : BTWhiteRevealViewController

@property (strong, nonatomic) BTBook *book;

@end
