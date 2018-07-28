//
//  BookHeadView.m
//  BookDetailsInheritanceDemo
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BookHeadView.h"
#import "BTUITools.h"

@implementation BookHeadView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = [UIColor blueColor];
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.titleLabel = [BTUITools BTCreateLabel:@"title" withFont:@"Helvetica Neue" withSize:40 withColor:[UIColor whiteColor]];
    self.authorLabel = [BTUITools BTCreateLabel:@"author" withFont:@"Helvetica Neue" withSize:30 withColor:[UIColor grayColor]];
    self.bookImageView = [UIImageView new];
    self.bookImageView.translatesAutoresizingMaskIntoConstraints = false;
    self.bookImageView.image = [UIImage imageNamed:@"shelfie-favicon"];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.authorLabel];
    [self addSubview:self.bookImageView];
    
    NSDictionary *elemsDict = NSDictionaryOfVariableBindings(_titleLabel, _authorLabel, _bookImageView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_bookImageView]-[_titleLabel]-[_authorLabel]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:elemsDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bookImageView]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:elemsDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_authorLabel]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:elemsDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:elemsDict]];
}

@end
