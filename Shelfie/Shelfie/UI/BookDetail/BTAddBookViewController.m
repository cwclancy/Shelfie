//
//  BTAddBookViewController.m
//  Shelfie
//
//  Created by Claudia Haddad on 7/26/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTAddBookViewController.h"
#import "BTBarcodeViewController.h"
#import "SWRevealViewController.h"
#import "GOBook.h"
#import <AVFoundation/AVFoundation.h>
#import <JSONModel/JSONModel.h>

@interface BTAddBookViewController () <BarcodeViewControllerDelegate>
@property (strong, nonatomic) GOBook *book;
@end

@implementation BTAddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setDelegate:self];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)makeBook:(NSDictionary *)book {
    NSDictionary *bookDictionary = book[@"items"][0][@"volumeInfo"];
    NSError *error;
    self.book = [[GOBook alloc] initWithDictionary:bookDictionary error:&error];
    //TODO: set up all of the views etc in the rest of this function
}



@end
