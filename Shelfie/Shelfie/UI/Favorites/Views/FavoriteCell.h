//
//  FavoriteCell.h
//  Shelfie
//
//  Created by Connor Clancy on 8/9/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBook.h"

@interface FavoriteCell : UICollectionViewCell
@property (strong, nonatomic) BTBook *book;
@end
