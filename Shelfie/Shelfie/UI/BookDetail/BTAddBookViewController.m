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
#import "BTPostManager.h"
#import <AVFoundation/AVFoundation.h>
#import <JSONModel/JSONModel.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "BTUserDefaults.h"

@interface BTAddBookViewController () <BarcodeViewControllerDelegate>
@property (strong, nonatomic) GOBook *book;
@property (strong, nonatomic) NSString *isbn;
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
    self.isbn = bookDictionary[@"industryIdentifiers"][1][@"identifier"];
    NSError *error;
    self.book = [[GOBook alloc] initWithDictionary:bookDictionary error:&error];
    [self postBook];
    // set up all of the views etc in the rest of this function
}

- (void)postBook {
    CLLocationCoordinate2D currentLocation = [BTUserDefaults getCurrentLocation];
    NSNumber *longitude = @(currentLocation.longitude);
    NSNumber *latitide = @(currentLocation.latitude);
    
    [[BTPostManager shared] addBookToDatabaseWithUserId:[FBSDKAccessToken currentAccessToken].userID title:@"title" author:self.book.authors[0] isbn:self.isbn date:self.book.publishedDate coverURL:self.book.imageLinks[@"thumbnail"] latitude:latitide longitude:longitude completion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error");
        } else {
            NSLog(@"posted");
            //TODO: segue to home view controller or profile
        }
    }];
    

}



@end
