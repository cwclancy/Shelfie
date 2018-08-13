//
//  ExploreCell.m
//  Shelfie
//
//  Created by Chaliana Rolon on 8/13/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "ExploreCell.h"

@interface ExploreCell ()

@property (strong, nonatomic) IBOutlet UIImageView *exploreIcon;

@end

@implementation ExploreCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) setSelected:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        [self.exploreIcon setImage: [UIImage imageNamed:@"iconmonstr-map-8-240 (2)"]];
    } else {
        [self.exploreIcon setImage: [UIImage imageNamed:@"iconmonstr-map-8-240 (1)"]];
    }
    
}


@end
