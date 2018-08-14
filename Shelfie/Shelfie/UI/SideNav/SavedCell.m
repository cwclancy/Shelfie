//
//  SavedCell.m
//  Shelfie
//
//  Created by Chaliana Rolon on 8/13/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "SavedCell.h"

@interface SavedCell ()

@property (weak, nonatomic) IBOutlet UIImageView *savedCell;

@end

@implementation SavedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        [self.savedCell setImage:[UIImage imageNamed:@"iconmonstr-favorite-3-240 (1)"]];
    } else {
        [self.savedCell setImage:[UIImage imageNamed:@"iconmonstr-favorite-4-240"]];
    }
}

@end
