//
//  BTUITools.m
//  tipCalculator
//
//  Created by Connor Clancy on 7/12/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BTUITools.h"

@implementation BTUITools

+ (UILabel *)BTCreateLabel:(NSString *)text withFont:(NSString *)font withSize:(CGFloat)size withColor:(UIColor *)color {
    UILabel *result = [UILabel new];
    result.text = text;
    result.font = [UIFont fontWithName:font size:size];
    result.textColor = color;
    result.translatesAutoresizingMaskIntoConstraints = false;
    return result;
}

@end
