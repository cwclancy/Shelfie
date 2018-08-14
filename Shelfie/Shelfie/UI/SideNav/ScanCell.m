//
//  ScanCell.m
//  Shelfie
//
//  Created by Chaliana Rolon on 8/13/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "ScanCell.h"

@interface ScanCell ()

@property (weak, nonatomic) IBOutlet UIImageView *scanIcon;

@end

@implementation ScanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void) setSelected:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        [self.scanIcon setImage:[UIImage imageNamed:@"iconmonstr-barcode-10-240 (1)"]];
    } else {
        [self.scanIcon setImage:[UIImage imageNamed:@"iconmonstr-barcode-10-240"]];
    }
    
}

@end
