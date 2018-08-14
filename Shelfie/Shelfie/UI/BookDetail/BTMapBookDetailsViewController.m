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
#import <FBSDKShareKit/FBSDKShareKit.h>
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

@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, assign) BOOL save;


@end

@implementation BTMapBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPage];
    [[BTUserDefaults shared] setStatusFalse];
}


- (IBAction)messengerPressed:(id)sender {
    // Content to share
    FBSDKShareMessengerGenericTemplateElement *element = [[FBSDKShareMessengerGenericTemplateElement alloc] init];
    element.title = self.book.title;
    element.subtitle = [NSString stringWithFormat:@"By %@", self.book.author];
    element.imageURL = [NSURL URLWithString:self.book.coverURL];
    FBSDKShareMessengerGenericTemplateContent *content = [[FBSDKShareMessengerGenericTemplateContent alloc] init];
    content.pageID = @"Shelfie";
    content.element = element;
    
    FBSDKMessageDialog *messageDialog = [[FBSDKMessageDialog alloc] init];
    messageDialog.shareContent = content;
    
    if ([messageDialog canShow]) {
        [messageDialog show];
        
    }
    
}

- (IBAction)saveClicked:(id)sender {
    if (!self.save) {
        [self.saveButton setImage:[UIImage imageNamed:@"saved.png"] forState:UIControlStateNormal];
        [[BTUserManager shared] addToBooksFavorite:self.book];
        self.save = true;
    }
    else if (self.save) {
 [self.saveButton setImage:[UIImage imageNamed:@"saveforlater.png"] forState:UIControlStateNormal];     [[BTUserManager shared] removeFromBooksFavorite:self.book];
        self.save = false;
}
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[BTUserDefaults shared] setStatusFalse];
}

-(void) createPage {
    [BTUserManager getUserWithID: self.book.userId completion:^(BTUser *owner) {
        NSLog(@"%@", owner);
        [self.coverImageView setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
        self.coverImageView.layer.shadowRadius = 2;
        self.coverImageView.layer.shadowOpacity = 0.8;
        self.titleLabel.text = self.book.title;
        self.authorLabel.text = self.book.author;
        NSString *formattedDate = [self.book.date substringToIndex:4];
        self.dateLabel.text = formattedDate;
        self.ownerNameLabel.text = owner.name;
        self.book.messengerId = owner.messenger_id;
        self.ownerImageView.layer.cornerRadius = self.ownerImageView.frame.size.width / 2;
        self.ownerImageView.clipsToBounds = YES;
        
        if (self.book.sell) {
            self.bookStatus.text = @"Selling";
        } else if (self.book.trade) {
            self.bookStatus.text = @"Trading";
        } else if (self.book.gift) {
            self.bookStatus.text = @"Gifting";
        }
        [self.ownerImageView setImageWithURL:[NSURL URLWithString:owner.picture]];
    }];
}

@end
