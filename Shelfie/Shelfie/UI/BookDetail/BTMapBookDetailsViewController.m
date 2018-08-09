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
@property (weak, nonatomic) IBOutlet UIView *bookStatusView;

@end

@implementation BTMapBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPage];
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

-(void) createPage {
    [BTUserManager getUserWithID: self.book.userId completion:^(BTUser *owner) {
        NSLog(@"%@", owner);
        [self.coverImageView setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
       // self.coverImageView.layer.cornerRadius = 3;
      //  self.coverImageView.layer.shadowOffset = CGSize(width: 0, height: 1.75);
        self.coverImageView.layer.shadowRadius = 2;
        self.coverImageView.layer.shadowOpacity = 0.8;
        self.titleLabel.text = self.book.title;
        self.authorLabel.text = self.book.author;
        NSString *formattedDate = [self.book.date substringToIndex:4];
        self.dateLabel.text = formattedDate;
        self.ownerNameLabel.text = owner.name;
        self.book.messengerId = owner.messenger_id;
        
        // BookStatusView Original position x = y =
        self.bookStatusView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        if (self.book.sell && self.book.gift && self.book.trade) {
            self.bookStatusView.transform = CGAffineTransformMakeTranslation(0, 0);
        } else if (self.book.sell) {
            self.bookStatus.text = @"Selling";
            self.bookStatusView.transform = CGAffineTransformMakeTranslation(55, 0);
        } else if (self.book.trade) {
            self.bookStatus.text = @"Trading";
            self.bookStatusView.transform = CGAffineTransformMakeTranslation(55, 0);
        } else if (self.book.gift) {
            self.bookStatus.text = @"Gifting";
            self.bookStatusView.transform = CGAffineTransformMakeTranslation(55, 0);
        } else if (self.book.trade && self.book.gift) {
            self.bookStatus.text = @"Trading, Gifting";
            self.bookStatusView.transform = CGAffineTransformMakeTranslation(40, 0);
        } else if (self.book.trade && self.book.sell) {
            self.bookStatus.text = @"Trading, Selling";
            self.bookStatusView.transform = CGAffineTransformMakeTranslation(40, 0);
        } else if (self.book.sell && self.book.gift) {
            self.bookStatus.text = @"Selling, Gifting";
            self.bookStatusView.transform = CGAffineTransformMakeTranslation(40, 0);
        }
        
        [self.ownerImageView setImageWithURL:[NSURL URLWithString:owner.picture]];
    }];
}

@end
