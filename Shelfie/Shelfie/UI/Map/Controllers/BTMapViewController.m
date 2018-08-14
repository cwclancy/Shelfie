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
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>



@interface BTMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, SWRevealViewControllerDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *mapBooks;
@property (strong, nonatomic) NSArray *filteredBooks;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIImageView *mapKeyImageView;
@property (nonatomic) MKCoordinateRegion currentLocation;
@property BOOL locationFlag;
@property BOOL firstPass;
@end

@implementation BTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstPass = [[BTUserDefaults shared] getStatus];
    SWRevealViewController *revealViewController = [self revealViewController];
    [self revealViewController].delegate = self;
    UIImage *image = [[UIImage imageNamed:@"iconmonstr-menu-thin-24.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:image  style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = barButton;
    if (revealViewController)
    {
        [barButton setTarget: self.revealViewController];
        [barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.mapView];
    CLLocationCoordinate2D myLocation = [BTUserDefaults getCurrentLocation];
    self.mapView.delegate = self;
    self.currentLocation = MKCoordinateRegionMake(myLocation, MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:self.currentLocation animated:false];
    UITapGestureRecognizer *screenTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetSearchBar)];
    [self.mapView addGestureRecognizer:screenTapped];
    self.mapView.showsUserLocation = YES;
    self.mapView.showsCompass = NO;
    
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
    [self drawMapKey];
}

- (void)viewDidAppear:(BOOL)animated {
    self.firstPass = [[BTUserDefaults shared] getStatus];
    if (!self.firstPass) {
        self.mapView.userInteractionEnabled = true;
        self.mapView.scrollEnabled = true;
        [[BTUserDefaults shared] setStatus];
    } else {
        self.mapView.userInteractionEnabled = false;
        self.mapView.scrollEnabled = false;
    }
}


- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position {
    self.mapView.userInteractionEnabled = !self.mapView.userInteractionEnabled;
    self.mapView.scrollEnabled = !self.mapView.scrollEnabled;
    [self.searchBar resignFirstResponder];
    self.searchBar.text = nil;
    self.filteredBooks = self.mapBooks;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self updateBookLocations:self.filteredBooks];
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
        if (book.latitude && book.longitude && book.own) {
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
    PinAnnotation *pin = annotation;
    annotationView.canShowCallout = YES;
    UIImage *image = [UIImage imageNamed:@"bigbookup"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:image forState:UIControlStateNormal];
    annotationView.rightCalloutAccessoryView = button;
    if (pin.book.gift) {
        annotationView.image = [UIImage imageNamed:@"yellowbook.png"];
    } else if (pin.book.trade) {
        annotationView.image = [UIImage imageNamed:@"bluebook.png"];
    } else {
        annotationView.image = [UIImage imageNamed:@"redbook.png"];
    }
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"mapToBookSegue" sender:view.annotation];
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    MKAnnotationView *currentLocation = [mapView viewForAnnotation:mapView.userLocation];
    currentLocation.enabled = NO;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"mapToBookSegue"]) {
        PinAnnotation *pinAnnotation = sender;
        BTMapBookDetailsViewController *mapBookViewController = [segue destinationViewController];
        mapBookViewController.book = pinAnnotation.book;
    }
}

- (void)resetSearchBar {
    [self.searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSString *firstChar = [searchText substringToIndex:1];
        if ([firstChar isEqualToString:@"#"]) {
            if ([searchText isEqualToString:@"#gift"]) {
                self.filteredBooks = [self getBooksGift];
            } else if ([searchText isEqualToString:@"#buy"]) {
                self.filteredBooks = [self getBooksBuy];
            } else if ([searchText isEqualToString:@"#trade"]) {
                self.filteredBooks = [self getBooksTrade];
            } else {
                self.filteredBooks = self.mapBooks;
            }
        } else {
            self.filteredBooks = [self.mapBooks filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(title contains[c] %@)", searchText]];
            NSLog(@"%@", self.filteredBooks);
        }
    } else {
        self.filteredBooks = self.mapBooks;
    }
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self updateBookLocations:self.filteredBooks];
}

- (NSMutableArray *)getBooksGift {
    NSMutableArray *res = [NSMutableArray new];
    for (int i = 0; i < self.mapBooks.count; i++) {
        BTBook *book = self.mapBooks[i];
        if (book.gift) {
            [res addObject:book];
        }
    }
    return res;
}

- (NSMutableArray *)getBooksTrade {
    NSMutableArray *res = [NSMutableArray new];
    for (int i = 0; i < self.mapBooks.count; i++) {
        BTBook *book = self.mapBooks[i];
        if (book.trade) {
            [res addObject:book];
        }
    }
    return res;
}

- (NSMutableArray *)getBooksBuy {
    NSMutableArray *res = [NSMutableArray new];
    for (int i = 0; i < self.mapBooks.count; i++) {
        BTBook *book = self.mapBooks[i];
        if (book.sell) {
            [res addObject:book];
        }
    }
    return res;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) drawMapKey {
    self.mapKeyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(255, 545, 87, 95)];
    self.mapKeyImageView.image = [UIImage imageNamed:@"mapkey"];
    [self.mapView addSubview:self.mapKeyImageView];
}



@end
