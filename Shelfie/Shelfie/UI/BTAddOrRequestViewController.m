//
//  AddOrRequestViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 8/6/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTAddOrRequestViewController.h"
#import "BTAddBookViewController.h"
#import "SWRevealViewController.h"

@interface BTAddOrRequestViewController ()
@property (nonatomic) BOOL have;
@property (nonatomic) BOOL want;
@end

@implementation BTAddOrRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    UIImage *image = [[UIImage imageNamed:@"white-burger.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:image  style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = barButton;
    if (revealViewController)
    {
        [barButton setTarget: self.revealViewController];
        [barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
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
