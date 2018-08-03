//
//  BTProfileViewController.m
//  Shelfie
//
//  Created by Claudia Haddad on 7/26/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTProfileViewController.h"
#import "SWRevealViewController.h"
#import "BTUser.h"
#import "UIImageView+AFNetworking.h"


@interface BTProfileViewController ()
@property (strong, nonatomic) BTUser *currentUser;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberBooksLabel;
@end

@implementation BTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.currentUser.picture]];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.nameLabel.text = self.currentUser.name;
    self.numberBooksLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.currentUser.booksHave.count];
    
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
