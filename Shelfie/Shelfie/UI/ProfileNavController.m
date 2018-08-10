//
//  ProfileNavController.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/10/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "ProfileNavController.h"

@interface ProfileNavController ()

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation ProfileNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navBar.title = @"claudia";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
