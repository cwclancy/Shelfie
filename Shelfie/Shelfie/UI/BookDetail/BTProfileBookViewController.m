//
//  BTProfileBookViewController.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/3/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTProfileBookViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BTUserManager.h"
#import "BTPostManager.h"

@interface BTProfileBookViewController ()

@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;

@end

@implementation BTProfileBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPage];

}

- (IBAction)deleteButton:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createPage {
    [self.bookCover setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
    [self.bookCover.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.bookCover.layer setBorderWidth: 2.0];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    NSString *formattedDate = [self.book.date substringToIndex:4];
    self.dateLabel.text = formattedDate;
    //TODO: GET owner of book from parse and fill out rest of field (call this funciton in completion of that)
}

- (IBAction)deleteButtonPressed:(id)sender {
    //TODO: add bool to see if it is a book request or owned
    if (self.own) {
        [[BTUserManager shared] removeFromBooksHave:self.book];
    } else {
        [[BTUserManager shared] removeFromBooksWant:self.book];
    }
    [[BTPostManager shared] removeBookFromDatabase:self.book];
    [BTUserManager getUserWithID:[FBSDKAccessToken currentAccessToken].userID completion:^(BTUser *owner) {
        [[BTUserManager shared] setUser:owner];
        NSLog(@"LOCAL USER REFRESHED");
    }];
    [self performSegueWithIdentifier:@"ProfileViewController" sender:self];
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
