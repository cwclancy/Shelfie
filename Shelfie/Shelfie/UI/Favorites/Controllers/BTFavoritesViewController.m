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

@interface BTFavoritesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) BTUser *currentUser;
@property (strong, nonatomic) NSMutableArray *favoriteBooks;
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
}

- (void)viewDidAppear:(BOOL)animated {
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    [BTUserManager getUserWithID:[FBSDKAccessToken currentAccessToken].userID completion:^(BTUser *owner) {
        self.currentUser = owner;
        self.favoriteBooks = [NSMutableArray new];
        [self fetchBooksFavorite:self.currentUser.booksWant];
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
    return self.favoriteBooks.count; //TODO: change to books favorite when buttons exist
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
            }
        }];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BTFavoriteBookViewController *favoriteBooksViewController = [segue destinationViewController];
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    favoriteBooksViewController.book = self.favoriteBooks[indexPath.item];
}


@end
