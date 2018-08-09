//
//  BTMapBookDetailsViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 8/2/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTMapBookDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BTUserManager.h"
#import "BTUserDefaults.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface BTMapBookDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (strong, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *postedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookStatus;

@end

@implementation BTMapBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPage];
    [[BTUserDefaults shared] setStatusFalse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)messengerPressed:(id)sender {
    NSString *stringURL = [NSString stringWithFormat:@"fb-messenger://user-thread/%@", self.book.messengerId];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    // Open Messenger app
    [[UIApplication sharedApplication] openURL:url options:[NSDictionary new] completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Messenger Open");
        }
    }];
}
- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) createPage {
    //TODO: GET owner of book from parse and fill out rest of field (call this funciton in completion of that)
    [BTUserManager getUserWithID: self.book.userId completion:^(BTUser *owner) {
        NSLog(@"%@", owner);
        [self.coverImageView setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
        [self.coverImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
        [self.coverImageView.layer setBorderWidth: 2.0];
        self.titleLabel.text = self.book.title;
        self.authorLabel.text = self.book.author;
        NSString *formattedDate = [self.book.date substringToIndex:4];
        self.dateLabel.text = formattedDate;
        self.ownerNameLabel.text = owner.name;
        self.book.messengerId = owner.messenger_id;
        
        if (self.book.sell && self.book.gift && self.book.trade) {
            self.bookStatus.text = @"Selling, Trading, Gifting";
        } else if (self.book.sell) {
            self.bookStatus.text = @"Selling";
        } else if (self.book.trade) {
            self.bookStatus.text = @"Trading";
        } else if (self.book.gift) {
            self.bookStatus.text = @"Gifting";
        } else if (self.book.trade && self.book.gift) {
            self.bookStatus.text = @"Trading, Gifting";
        } else if (self.book.trade && self.book.sell) {
            self.bookStatus.text = @"Trading, Selling";
        } else if (self.book.sell && self.book.gift) {
            self.bookStatus.text = @"Selling, Gifting";
        }
        
        [self.ownerImageView setImageWithURL:[NSURL URLWithString:owner.picture]];
    }];
}

@end
