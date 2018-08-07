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
#import "UIImageView+AFNetworking.h"


@interface BTProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) BTUser *currentUser;

@property (strong, nonatomic) IBOutlet UICollectionView *booksOwnedView;
@property (strong, nonatomic) IBOutlet UICollectionView *booksRequestedView;

@end

@implementation BTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    
    self.booksOwnedView.delegate = self;
    self.booksOwnedView.dataSource = self;
    [self.booksOwnedView reloadData];
    
    self.booksRequestedView.delegate = self;
    self.booksRequestedView.dataSource = self;
    [self.booksRequestedView reloadData];
    
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
        if (self.currentUser.booksHave.count != 0) {
         NSString *coverURL = self.currentUser.booksHave[indexPath.row];
        [cellA setContents:coverURL];
        } else {
            NSLog(@"no books in own array!");
            UIImage *image = [UIImage imageNamed: @"iconmonstr-menu.png"];
            [cellA.ownBook setImage:image];
        }
        return cellA;   
        
    }
    else {
        RequestCollectionViewCell *cellB = [collectionView dequeueReusableCellWithReuseIdentifier:@"requestCell" forIndexPath:indexPath];
        if (self.currentUser.booksWant.count != 0) {
        NSString *coverURL = self.currentUser.booksWant[indexPath.row];
        [cellB setContents:coverURL];
        } else {
            NSLog(@"no books in want array!");
            UIImage *image = [UIImage imageNamed: @"iconmonstr-menu.png"];
            [cellB.requestBook setImage:image];
        }
    return cellB;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.booksOwnedView) {
       return self.currentUser.booksHave.count;
    }
       return self.currentUser.booksWant.count;
  
}

@end
