//
//  BTFavoriteBookViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 8/9/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTFavoriteBookViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BTUserManager.h"

@interface BTFavoriteBookViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BTFavoriteBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.coverImageView setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    self.dateLabel.text = self.book.date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    // [[BTUserManager shared] removeFromBooksFavorite:self.book];
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
