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
#import "BTGetManager.h"
#import "BTBook.h"
#import "BTProfileBookViewController.h"
#import "UIImageView+AFNetworking.h"


@interface BTProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) BTUser *currentUser;

@property (strong, nonatomic) IBOutlet UICollectionView *booksOwnedView;
@property (strong, nonatomic) IBOutlet UICollectionView *booksRequestedView;
@property (strong, nonatomic) NSMutableArray *booksHave;
@property (strong, nonatomic) NSMutableArray *booksWant;

@end

@implementation BTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    [self fetchBooksHave:self.currentUser.booksHave];
    [self fetchBooksWant:self.currentUser.booksWant];
    self.booksHave = [NSMutableArray new];
    self.booksWant = [NSMutableArray new];
    self.booksOwnedView.delegate = self;
    self.booksOwnedView.dataSource = self;
    self.booksOwnedView.alwaysBounceHorizontal = YES;
    [self.booksOwnedView reloadData];
    self.booksRequestedView.delegate = self;
    self.booksRequestedView.dataSource = self;
    self.booksRequestedView.alwaysBounceHorizontal = YES;
    [self.booksRequestedView reloadData];
}




- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (collectionView == self.booksOwnedView) {
        OwnCollectionViewCell *cellA = [collectionView dequeueReusableCellWithReuseIdentifier:@"ownedCell" forIndexPath:indexPath];
        if (self.currentUser.booksHave.count != 0) {
            BTBook *currentBook = self.booksHave[indexPath.row];
            NSString *coverURL = currentBook.coverURL;
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
            BTBook *currentBook = self.booksWant[indexPath.row];
            NSString *coverURL = currentBook.coverURL;
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
       return self.booksHave.count;
    }
       return self.booksWant.count;

}

- (void)fetchBooksHave:(NSArray *)pointerArray {
    for (int i = 0; i < pointerArray.count; i++) {
        BTBook *currentBook = pointerArray[i];
        NSString *bookId = currentBook.objectId;
        [[BTBook query] getObjectInBackgroundWithId:bookId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [self.booksHave addObject:object];
                if (self.booksHave.count == pointerArray.count) {
                    NSLog(@"here");
                    [self.booksOwnedView reloadData];
                }
            }
        }];
    }
}

- (void)fetchBooksWant:(NSArray *)pointerArray {
    for (int i = 0; i < pointerArray.count; i++) {
        BTBook *currentBook = pointerArray[i];
        NSString *bookId = currentBook.objectId;
        [[BTBook query] getObjectInBackgroundWithId:bookId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [self.booksWant addObject:object];
                if (self.booksWant.count == pointerArray.count) {
                    NSLog(@"here");
                    [self.booksRequestedView reloadData];
                }
            }
        }];
    }
}

/*
- (void) viewDidAppear:(BOOL)animated {
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    [self.booksOwnedView reloadData];
    [self.booksRequestedView reloadData];
}
 */

 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.booksOwnedView indexPathForCell:tappedCell];
    BTBook *currentBook = self.booksHave[indexPath.item];
    BTProfileBookViewController *profileDetailsViewController = [segue destinationViewController];
    profileDetailsViewController.book = currentBook;  
 }
@end
