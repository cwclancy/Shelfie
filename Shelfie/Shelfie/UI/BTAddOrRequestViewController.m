//
//  AddOrRequestViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 8/6/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTAddOrRequestViewController.h"
#import "BTAddBookViewController.h"

@interface BTAddOrRequestViewController ()
@property (nonatomic) BOOL have;
@property (nonatomic) BOOL want;
@end

@implementation BTAddOrRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestButtonPressed:(id)sender {
    self.want = true;
    [self performSegueWithIdentifier:@"addRequestToPublishSegue" sender:nil];
}


- (IBAction)addButtonPressed:(id)sender {
    self.have = true;
    [self performSegueWithIdentifier:@"addRequestToPublishSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BTAddBookViewController *addBookController = [segue destinationViewController];
    addBookController.have = self.have;
    addBookController.want = self.want;
}


@end
