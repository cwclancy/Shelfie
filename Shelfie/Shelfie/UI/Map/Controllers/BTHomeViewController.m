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
#import "BTUIServices.h"

@interface BTHomeViewController () <UISearchBarDelegate>
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIView *tapCheckView;
@end

@implementation BTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"HOME VIEW : %@", [[BTUserManager shared] getCurrentUser]);
    self.searchBar = [BTUIServices createSearchBarWithDimensions:CGRectMake(30, 70, 320, 44)];
    self.searchBar.delegate = self;
    [self.view addSubview:self.tapCheckView];
    [self.view addSubview:self.searchBar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tappedScreen:(id)sender {
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}


@end
