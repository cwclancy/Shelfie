//
//  BTProfileViewController.m
//  Shelfie
//
//  Created by Claudia Haddad on 7/26/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTProfileViewController.h"
#import "SWRevealViewController.h"
#import "BTUser.h"
#import "UIImageView+AFNetworking.h"
#import "OwnCollectionViewCell.h"
#import "RequestCollectionViewCell.h"
#import "BTBook.h"


@interface BTProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) BTUser *currentUser;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;

@property (strong, nonatomic) NSArray *booksOwned;
@property (strong, nonatomic) NSArray *booksRequested;

@property (strong, nonatomic) IBOutlet UICollectionView *booksOwnedView;
@property (strong, nonatomic) IBOutlet UICollectionView *booksRequestedView;


@end

@implementation BTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    
    [self.profilePic setImageWithURL:[NSURL URLWithString:self.currentUser.picture]];
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;
    self.nameLabel.text = self.currentUser.name;
    
    self.booksOwnedView.delegate = self;
    self.booksOwnedView.dataSource = self;
    [self.booksOwnedView reloadData];
    
    self.booksRequestedView.delegate = self;
    self.booksRequestedView.dataSource = self;
    [self.booksRequestedView reloadData];
    
   // self.numberBooksLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.currentUser.booksHave.count];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (collectionView == self.booksOwnedView) {
        OwnCollectionViewCell *cellA = [collectionView dequeueReusableCellWithReuseIdentifier:@"ownedCell" forIndexPath:indexPath];
        BTBook *book = self.booksOwned[indexPath.row];
        cellA.book = book;
        [cellA setContents];
        return cellA;
    }  else {
         RequestCollectionViewCell *cellB = [collectionView dequeueReusableCellWithReuseIdentifier:@"requestCell" forIndexPath:indexPath];
        BTBook *book = self.booksRequested[indexPath.row];
       // cellB.book = book;
      //  [cellB setContents];
    return cellB;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.booksOwnedView) {
       return self.booksOwned.count;
    }
       return self.booksRequested.count;
  
}

@end
