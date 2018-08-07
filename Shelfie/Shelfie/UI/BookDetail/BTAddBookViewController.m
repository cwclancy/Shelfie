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
#import "UIImageView+AFNetworking.h"
#import "BTPostManager.h"
#import "BTUserDefaults.h"
#import "BTUserManager.h"
#import "BTBookAPIManager.h"
#import "BTCompletedRequestViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <JSONModel/JSONModel.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BTAddBookViewController () <BarcodeViewControllerDelegate>

@property (strong, nonatomic) GOBook *book;
@property (strong, nonatomic) NSString *coverURL;

@property (strong, nonatomic) IBOutlet UIButton *buySellButton;
@property (strong, nonatomic) IBOutlet UIButton *tradeButton;
@property (strong, nonatomic) IBOutlet UIButton *giftButton;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;

//@property (strong, nonatomic) NSInteger *bookDistance;
@property (nonatomic, assign) BOOL buySell;
@property (nonatomic, assign) BOOL trade;
@property (nonatomic, assign) BOOL gift;
@property (nonatomic, assign) BOOL own;
@property (nonatomic, assign) BOOL sell;
@end

@implementation BTAddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.have) {
        self.own = true;
    }
    
    
}

- (void)makeBook:(NSDictionary *)book {
    NSDictionary *bookDictionary = book[@"items"][0][@"volumeInfo"];
    self.book = [GOBook new];
    self.book.title = bookDictionary[@"title"];
    self.book.imageLinks = bookDictionary[@"imageLinks"];
    self.book.authors = bookDictionary[@"authors"];
    self.book.date = bookDictionary[@"publishedDate"];
    self.coverURL = self.book.imageLinks[@"thumbnail"];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.authors[0];
    self.dateLabel.text = self.book.date;
    [self.bookCover setImageWithURL:[NSURL URLWithString:self.coverURL]];
    [self.bookCover.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.bookCover.layer setBorderWidth: 2.0];
}


- (IBAction)sellClicked:(id)sender {
    if (!self.buySell) {
        self.buySell = true;
        [self.buySellButton setImage:[UIImage imageNamed:@"iconmonstr-circle-1-240.png"] forState:UIControlStateNormal];
    } else if (self.buySell) {
        self.buySell = false;
        [self.buySellButton setImage:[UIImage imageNamed:@"iconmonstr-circle-thin-32.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)tradeClicked:(id)sender {
    if (!self.trade) {
        self.trade = true;
        [self.tradeButton setImage:[UIImage imageNamed:@"iconmonstr-circle-1-240.png"] forState:UIControlStateNormal];
    } else if (self.trade) {
        self.trade = false;
        [self.tradeButton setImage:[UIImage imageNamed:@"iconmonstr-circle-thin-32.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)giftClicked:(id)sender {

if (!self.gift) {
        self.gift = true;
        [self.giftButton setImage:[UIImage imageNamed:@"iconmonstr-circle-1-240.png"] forState:UIControlStateNormal];
    } else if (self.gift) {
        self.gift = false;
        [self.giftButton setImage:[UIImage imageNamed:@"iconmonstr-circle-thin-32.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)sliderValueChanged:(id)sender {
    //self.slider.value = round(self.slider.value);
    self.sliderLabel.text = [NSString stringWithFormat:@"%.0f miles", self.slider.value];
}


- (IBAction)submitClicked:(id)sender {
    CLLocationCoordinate2D currentLocation = [BTUserDefaults getCurrentLocation];
    [BTPostManager addBookToDatabaseWithUserId:[FBSDKAccessToken currentAccessToken].userID title:self.book.title author:self.book.authors[0] isbn:self.isbn date:self.book.date coverURL:self.coverURL latitude:@(currentLocation.latitude) longitude:@(currentLocation.longitude) own:self.own gift:self.gift trade:self.trade sell:self.buySell completion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
        } else {
            NSLog(@"%@", error);
        }
    }];
    if (self.own) {
        [[BTUserManager shared] addToBooksHave:self.coverURL];
    } else {
        [[BTUserManager shared] addToBooksWant:self.coverURL];
    }
    [self performSegueWithIdentifier:@"publishSegue" sender:nil];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"publishSegue"]) {
         BTCompletedRequestViewController *publishViewController = [segue destinationViewController];
         publishViewController.bookTitle = self.titleLabel.text;
         publishViewController.coverURL = self.coverURL;
         publishViewController.date = self.dateLabel.text;
         publishViewController.author = self.authorLabel.text;
     }
 }


@end
