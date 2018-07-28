//
//  BaseView.m
//  BookDetailsInheritanceDemo
//
//  Created by Connor Clancy on 7/27/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BaseView.h"
#import "BookHeadView.h"

@implementation BaseView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self loadTheView];
    }
    return self;
}


- (void) loadTheView {
    self.headView = [BookHeadView new];
    [self addSubview:self.headView];
    
    NSDictionary *elemsDict = NSDictionaryOfVariableBindings(_headView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_headView(230@1000)]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:elemsDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_headView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:elemsDict]];
}
@end
