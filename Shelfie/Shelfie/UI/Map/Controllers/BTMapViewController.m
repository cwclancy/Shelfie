//
//  MapViewController.m
//  Shelfie
//
//  Created by Connor Clancy on 7/31/18.
//  Copyright © 2018 BookTrader. All rights reserved.
//

#import "BTMapViewController.h"
#import "BTUserDefaults.h"
#import "BTGetManager.h"
#import "BTBook.h"
#import "PinAnnotation.h"
#import "BTMapBookDetailsViewController.h"
#import "BTUIServices.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>



@interface BTMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *mapBooks;
@property (strong, nonatomic) NSArray *filteredBooks;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (nonatomic) MKCoordinateRegion currentLocation;
@property BOOL locationFlag;
@end

@implementation BTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.mapView];
    CLLocationCoordinate2D myLocation = [BTUserDefaults getCurrentLocation];
    self.mapView.delegate = self;
    self.currentLocation = MKCoordinateRegionMake(myLocation, MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:self.currentLocation animated:false];
    UITapGestureRecognizer *screenTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetSearchBar)];
    [self.mapView addGestureRecognizer:screenTapped];
    
    self.locationFlag = true;
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    [[BTGetManager shared] fetchBooksWithCompletion:^(NSArray *books, NSError *error) {
        if (error) {
            NSLog(@"error");
        } else {
            self.mapBooks = books;
            [self updateBookLocations:books];
        }
    }];
    
    self.searchBar = [BTUIServices createSearchBarWithDimensions:CGRectMake(30, 70, 320, 44)];
    self.searchBar.delegate = self;
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    NSLog(@"I failed");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (self.locationFlag) {
        CLLocation *location = [locations lastObject];
        MKCoordinateRegion currentLocation = MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));
        self.currentLocation = currentLocation;
        [self.mapView setRegion:currentLocation animated:true];
        self.locationFlag = false;
        [BTUserDefaults setCurrentLocation:currentLocation];
    }
}

- (void)updateBookLocations:(NSArray *)books {
    for (int i = 0; i < books.count; i++) {
        BTBook *book = books[i];
        if (book.latitude && book.longitude) {
            CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake([book.latitude doubleValue], [book.longitude doubleValue]);
            PinAnnotation *annotation = [[PinAnnotation alloc] initWithBook:book coordinate:centerCoordinate title:book.title];
            [self.mapView addAnnotation:annotation];
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSString *identifier = @"identity";
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    PinAnnotation *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.image = [UIImage imageNamed:@"bookmap.png"];
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"mapToBookSegue" sender:view.annotation];
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"mapToBookSegue"]) {
        PinAnnotation *pinAnnotation = sender;
        BTMapBookDetailsViewController *mapBookViewController = [segue destinationViewController];
        mapBookViewController.book = pinAnnotation.book;
    }
}

- (void)resetSearchBar {
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        self.filteredBooks = [self.mapBooks filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(title contains[c] %@)", searchText]];
        NSLog(@"%@", self.filteredBooks);
        
    } else {
        self.filteredBooks = self.mapBooks;
    }
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self updateBookLocations:self.filteredBooks];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
