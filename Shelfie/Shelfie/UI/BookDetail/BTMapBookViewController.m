//
//  BTMapBookViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 8/2/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTMapBookViewController.h"
#import "UIImageView+AFNetworking.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>


@interface BTMapBookViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookAddedLabel;
@end

@implementation BTMapBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pressedMessage:(id)sender {
    [FBSDKMessengerSharer openMessenger];
}

- (void)fillPage {
    [self.coverImageView setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    self.dateLabel.text = self.book.date;
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
