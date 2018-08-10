//
//  OwnCollectionViewCell.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/6/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "OwnCollectionViewCell.h"

@implementation OwnCollectionViewCell

- (void)setContents: (NSString *)coverURL {
    
  [self.ownBook setImageWithURL:[NSURL URLWithString:coverURL]];
    self.ownBook.layer.shadowRadius = 2;
    self.ownBook.layer.shadowOpacity = 0.8;
  //  [self.bookCover loadInBackground];
    
}
@end
