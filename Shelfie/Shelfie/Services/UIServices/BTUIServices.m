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
    return searchBar;
}

@end
