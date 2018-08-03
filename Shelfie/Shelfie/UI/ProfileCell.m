//
//  ProfileCell.m
//  Shelfie
//
//  Created by Connor Clancy on 8/3/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "ProfileCell.h"
#import "BTUser.h"
#import "BTUserManager.h"
#import "UIImageView+AFNetworking.h"


@interface ProfileCell ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) BTUser *currentUser;
@end

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.currentUser = [[BTUserManager shared] getCurrentUser];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.currentUser.picture]];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.nameLabel.text = self.currentUser.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
