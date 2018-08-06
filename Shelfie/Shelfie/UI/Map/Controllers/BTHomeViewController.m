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
    // Verify if User doesn't exist on Parse given its FB userID
    if (![[BTUserManager shared] getCurrentUser]) {
        [self isUserOnParse:[FBSDKAccessToken currentAccessToken].userID];
    }
    
    
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

// Verify if User doesn't exist on Parse given its FB userID
- (void) isUserOnParse: (NSString *) userID {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:userID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error) {
            if (objects.count==0) { // If user is not on Parse
                NSLog(@"Not on Parse(?)");
                // Create User by going through the loggin (ORIGINAL INITIALIZATION)
                [self performSegueWithIdentifier:@"HomeToLogin" sender:self];
            } else {
                NSLog(@"Exists on Parse");// Initiate User
                [[BTUserManager shared] setUser: (BTUser *) objects[0]];
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}


@end
