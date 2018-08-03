//
//  BarcodeViewController.h
//  Shelfie
//
//  Created by Connor Clancy on 7/30/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTWhiteRevealViewController.h"

@protocol BarcodeViewControllerDelegate
-(void)makeBook:(NSDictionary *)book;
@end

@interface BTBarcodeViewController : BTWhiteRevealViewController
@property (nonatomic, weak) id<BarcodeViewControllerDelegate> delegate;
@end
