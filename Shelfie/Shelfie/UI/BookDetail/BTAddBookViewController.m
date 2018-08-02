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
@property (strong, nonatomic) NSString *coverURL;

@property (strong, nonatomic) IBOutlet UIButton *sellButton;
@property (strong, nonatomic) IBOutlet UIButton *tradeButton;
@property (strong, nonatomic) IBOutlet UIButton *giftButton;
@property (strong, nonatomic) IBOutlet UIButton *currentLocation;

@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;

@property (nonatomic, assign) BOOL sell;
@property (nonatomic, assign) BOOL trade;
@property (nonatomic, assign) BOOL gift;
@property (nonatomic, assign) BOOL location;
@property (nonatomic, assign) BOOL own;

@property (nonatomic) NSNumber *p_bookLat;
@property (nonatomic) NSNumber *p_bookLon;
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
    self.coverURL = self.book.imageLinks[@"small"];
    NSURL *url = [NSURL URLWithString: self.coverURL];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.authors[0];
    self.dateLabel.text = self.book.date;
    self.bookCover.image = [UIImage imageWithData:imageData];
}

- (IBAction)useCurrentLocation:(id)sender {
    if (!self.location) {
        self.location = true;
        [self.currentLocation setImage:[UIImage imageNamed:@"iconmonstr-circle-1-240.png"] forState:UIControlStateNormal];
    } else if (self.location) {
        self.location = false;
        [self.currentLocation setImage:[UIImage imageNamed:@"iconmonstr-circle-thin-32.png"] forState:UIControlStateNormal];
        //TODO:set book location with defaults (if we do defaults)
    }
}

- (IBAction)sellClicked:(id)sender {
    if (!self.sell) {
        self.sell = true;
        [self.sellButton setImage:[UIImage imageNamed:@"iconmonstr-circle-1-240.png"] forState:UIControlStateNormal];
    } else if (self.sell) {
        self.sell = false;
        [self.sellButton setImage:[UIImage imageNamed:@"iconmonstr-circle-thin-32.png"] forState:UIControlStateNormal];
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




@end
