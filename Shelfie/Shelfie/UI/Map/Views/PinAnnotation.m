//
//  PinAnnotation.m
//  Shelfie
//
//  Created by Connor Clancy on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "PinAnnotation.h"

@implementation PinAnnotation

- (instancetype)initWithBook:(BTBook *)book coordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title{
    self = [super init];
    if (self) {
        self.book = book;
        self.coordinate = coordinate;
        self.title = title;
    }
    return self;
}

@end
