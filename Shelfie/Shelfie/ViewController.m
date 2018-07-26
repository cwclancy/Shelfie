//
//  ViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 7/26/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (strong, nonatomic) IBOutlet UIScreenEdgePanGestureRecognizer *swipe;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController)
    {
        [self.barButton setTarget: self.revealViewController];
        [self.barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
