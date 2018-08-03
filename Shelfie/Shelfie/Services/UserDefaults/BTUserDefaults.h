//
//  BTUserDefaults.h
//  Shelfie
//
//  Created by Connor Clancy on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BTUserDefaults : NSObject
+ (void) setCurrentLocation:(MKCoordinateRegion)currentLocation;
+ (CLLocationCoordinate2D) getCurrentLocation;
@end
