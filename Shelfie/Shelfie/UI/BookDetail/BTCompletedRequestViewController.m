//
//  BTCompletedRequestViewController.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/2/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTCompletedRequestViewController.h"
#import "BTHomeViewController.h"
#import "UIImageView+AFNetworking.h"


@interface BTCompletedRequestViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BTCompletedRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.coverImageView setImageWithURL:[NSURL URLWithString:self.coverURL]];
    self.titleLabel.text = self.bookTitle;
    self.authorLabel.text = self.author;
    NSString *formattedDate = [self.date substringToIndex:4];
    self.dateLabel.text = formattedDate;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)keepExploring:(id)sender {
    [self performSegueWithIdentifier:@"exploreSegue" sender:nil];
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
