//
//  ProfileCollectionViewCell.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/6/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "ProfileCollectionViewCell.h"

@implementation ProfileCollectionViewCell

- (void)setContents {
    
  [self.bookCover setImageWithURL:[NSURL URLWithString:self.book.coverURL]];
  //  [self.bookCover loadInBackground];
    
}
@end
