//
//  BTMapBookDetailsViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 8/2/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTMapBookDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface BTMapBookDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (strong, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *postedDateLabel;

@end

@implementation BTMapBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)messengerPressed:(id)sender {
    [FBSDKMessengerSharer openMessenger];
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
    [self.coverImageView setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
    [self.coverImageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.coverImageView.layer setBorderWidth: 2.0];
    self.titleLabel.text = self.book.title;
   // self.authorLabel.text = self.book.author;
    self.dateLabel.text = self.book.date;
    //TODO: GET owner of book from parse and fill out rest of field (call this funciton in completion of that)
}

@end
