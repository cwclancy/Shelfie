//
//  FavoritesViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 8/9/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTFavoritesViewController.h"
#import "FavoriteCell.h"
#import "BTUser.h"
#import "BTUserManager.h"
#import "BTFavoriteBookViewController.h"
#import "NoBooksSavedView.h"
#import "BTUIServices.h"
#import "BTUserDefaults.h"

@interface BTFavoritesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) BTUser *currentUser;
@property (strong, nonatomic) NSMutableArray *favoriteBooks;
@property (strong, nonatomic) IBOutlet NoBooksSavedView *noBooksSavedView;
@property (strong, nonatomic) UIView *savedView;
@end

@implementation BTFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = self.collectionView.frame.size.width/postersPerLine;
    CGFloat itemHeight = 1.5 * itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    [self.noBooksSavedView removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated {
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    [BTUserManager getUserWithID:[FBSDKAccessToken currentAccessToken].userID completion:^(BTUser *owner) {
        self.currentUser = owner;
        self.favoriteBooks = [NSMutableArray new];
        [self fetchBooksFavorite:self.currentUser.booksFavorite];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FavoriteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    cell.book = self.favoriteBooks[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favoriteBooks.count; 
}

- (void)fetchBooksFavorite:(NSArray *)pointerArray {
    for (int i = 0; i < pointerArray.count; i++) {
        BTBook *currentBook = pointerArray[i];
        NSString *bookId = currentBook.objectId;
        [[BTBook query] getObjectInBackgroundWithId:bookId block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                [self.favoriteBooks addObject:object];
                if (self.favoriteBooks.count == pointerArray.count) {
                    NSLog(@"here");
                    [self.collectionView reloadData];
                }
                if (self.favoriteBooks.count == 0) {
                    [self drawSavedView];
                }
            }
        }];
    }
}

- (IBAction)exploreButtonTapped:(id)sender {
    [self.noBooksSavedView removeFromSuperview];
    [self performSegueWithIdentifier:@"savedBooksToHome" sender:nil];
    [[BTUserDefaults shared] setStatusFalse];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![[segue identifier] isEqualToString:@"savedBooksToHome"]) {
        BTFavoriteBookViewController *favoriteBooksViewController = [segue destinationViewController];
        UICollectionViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        favoriteBooksViewController.book = self.favoriteBooks[indexPath.item];
    }
}

- (void)drawSavedView {
    [self.view addSubview:self.noBooksSavedView];
}


@end
