//
//  RequestCollectionViewCell.m
//  Shelfie
//
//  Created by Claudia Haddad on 8/6/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "RequestCollectionViewCell.h"

@implementation RequestCollectionViewCell
    
    - (void)setContents: (NSString *)coverURL {
        
        [self.requestBook setImageWithURL:[NSURL URLWithString:coverURL]];
}
@end
