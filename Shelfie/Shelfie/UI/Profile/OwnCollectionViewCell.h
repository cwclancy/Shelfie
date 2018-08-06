//
//  OwnCollectionViewCell.h
//  Shelfie
//
//  Created by Claudia Haddad on 8/6/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBook.h"
#import "UIImageView+AFNetworking.h"


@interface OwnCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ownBook;
@property (strong, nonatomic) BTBook *book;
- (void) setContents;
@end
