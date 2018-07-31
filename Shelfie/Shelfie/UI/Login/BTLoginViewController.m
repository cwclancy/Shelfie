//
//  BTLoginViewController.m
//  Shelfie
//
//  Created by Claudia Haddad on 7/26/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTLoginViewController.h"
#import "BTFbAPIManager.h"

@interface BTLoginViewController ()

@end

@implementation BTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Handle clicks on the login/logout button
    [self.loginButton addTarget : self action : @selector (onLoginClicked) forControlEvents : UIControlEventTouchUpInside ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onLoginClicked {
    [[BTFbAPIManager shared] login:self];
}

- (void) viewDidAppear:(BOOL)animated {
    // If there is a current session going
    if([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"loginToHome" sender:self];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
