//
//  PinAnnotation.h
//  Shelfie
//
//  Created by Connor Clancy on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "BTBook.h"

@interface PinAnnotation : NSObject <MKAnnotation>
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) BTBook *book;
@property (nonatomic) CLLocationCoordinate2D coordinate;
- (instancetype)initWithBook:(BTBook *)book coordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
@end
