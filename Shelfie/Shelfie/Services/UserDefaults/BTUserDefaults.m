//
//  BTUserDefaults.m
//  Shelfie
//
//  Created by Connor Clancy on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTUserDefaults.h"

@interface BTUserDefaults ()
@property BOOL status;
@end

@implementation BTUserDefaults

+ (void)setCurrentLocation:(MKCoordinateRegion)currentLocation {
    NSDictionary *locationData = @{@"latitude":@(currentLocation.center.latitude), @"longitude":@(currentLocation.center.longitude)};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:locationData forKey:@"myLocation"];
}

+ (CLLocationCoordinate2D)getCurrentLocation {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *locationDictionary = [defaults objectForKey:@"myLocation"];
    CLLocationCoordinate2D res = CLLocationCoordinate2DMake(0, 0);
    if (locationDictionary) {
        CLLocationDegrees latitude = [locationDictionary[@"latitude"] doubleValue];
        CLLocationDegrees longitude = [locationDictionary[@"longitude"] doubleValue];
        return CLLocationCoordinate2DMake(latitude, longitude);
    }
    else {
        return res;
    }
}

+ (instancetype) shared {
    static BTUserDefaults *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (BOOL)getStatus {
    return self.status;
}

- (void)setStatus {
    self.status = YES;
}

- (void)setStatusFalse {
    self.status = NO;
}


@end
