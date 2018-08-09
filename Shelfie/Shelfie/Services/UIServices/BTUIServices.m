//
//  BTUIServices.m
//  Shelfie
//
//  Created by Connor Clancy on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTUIServices.h"

@implementation BTUIServices

+ (UISearchBar *)createSearchBarWithDimensions:(CGRect)dimensions {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:dimensions];
    searchBar.layer.borderWidth = 0.0;
    [searchBar setBackgroundImage:[UIImage new]];
    [searchBar setBarTintColor:[UIColor clearColor]];
    [searchBar setBackgroundColor:[UIColor clearColor]];
    searchBar.translucent = YES;
    searchBar.layer.opacity = 0.5;
    return searchBar;
}

+ (UILabel *)BTCreateLabel:(NSString *)text withFont:(NSString *)font withSize:(CGFloat)size withColor:(UIColor *)color {
    UILabel *result = [UILabel new];
    result.text = text;
    result.font = [UIFont fontWithName:font size:size];
    result.textColor = color;
    return result;
}

@end
