//
//  OwnCollectionViewCell.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/6/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "OwnCollectionViewCell.h"

@implementation OwnCollectionViewCell

- (void)setContents {
    
  [self.ownBook setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
  //  [self.bookCover loadInBackground];
    
}
@end
