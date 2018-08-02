//
//  BTHomeViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 7/26/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTHomeViewController.h"
#import "SWRevealViewController.h"
#import "BTUserManager.h"

@interface BTHomeViewController ()
@end

@implementation BTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"HOME VIEW : %@", [[BTUserManager shared] getCurrentUser]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
