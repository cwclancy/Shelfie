//
//  BTCompletedRequestViewController.h
//  Shelfie
//
//  Created by Claudia Haddad on 8/2/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"BTRevealHeadViewController.h"

@interface BTCompletedRequestViewController :  BTRevealHeadViewController

@property (strong, nonatomic) NSString *coverURL;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *bookTitle;
@property (strong, nonatomic) NSString *date;
@end
