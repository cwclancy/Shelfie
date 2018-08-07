//
//  BTAddBookViewController.h
//  Shelfie
//
//  Created by Claudia Haddad on 7/26/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTRevealHeadViewController.h"
#import "BTWhiteRevealViewController.h"
#import "BTBarcodeViewController.h"

@interface BTAddBookViewController : BTBarcodeViewController
@property (strong, nonatomic) NSString *isbn;
@property (nonatomic) BOOL have;
@property (nonatomic) BOOL want;
@end
