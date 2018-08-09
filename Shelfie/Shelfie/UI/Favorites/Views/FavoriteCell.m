//
//  FavoriteCell.m
//  Shelfie
//
//  Created by Connor Clancy on 8/9/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "FavoriteCell.h"
#import "UIImageView+AFNetworking.h"


@interface FavoriteCell ()
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@end

@implementation FavoriteCell

-(void)setBook:(BTBook *)book {
    _book = book;
    [self.bookCover setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
}

@end
