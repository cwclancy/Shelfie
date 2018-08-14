//
//  SettingsCell.m
//  Shelfie
//
//  Created by Chaliana Rolon on 8/13/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "SettingsCell.h"

@interface SettingsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *settingIcon;

@end

@implementation SettingsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        [self.settingIcon setImage:[UIImage imageNamed:@"iconmonstr-gear-2-32"]];
    } else {
        [self.settingIcon setImage:[UIImage imageNamed:@"iconmonstr-gear-2-240 (2)"]];
    }

}

@end
