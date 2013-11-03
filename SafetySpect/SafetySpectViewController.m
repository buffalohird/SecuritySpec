//
//  SafetySpectViewController.m
//  SafetySpect
//
//  Created by Akshar Bonu  on 11/2/13.
//  Copyright (c) 2013 Buffalo&Akshar&Mark. All rights reserved.
//

#import "SafetySpectViewController.h"
#import "SafetySpectSettingsViewController.h"
#import <Parse/Parse.h>

@interface SafetySpectViewController ()

@end

@implementation SafetySpectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.locationManager.delegate = self; 
    self.mapView.showsUserLocation = YES;
    self.crimeSpotting = [[CrimeSpotting alloc] init];
    [self.crimeSpotting getDataFromUrl:@"http://sanfrancisco.crimespotting.org/crime-data?format=json&count=1000"];
    
    self.userGenerated = [[UserGenerated alloc] init];
    [self.userGenerated getDataForParseObject: @"UserCrimeAnnotation"];
    
    self.twitter = YES;
    self.police = YES;
    self.user = YES;
    
    if([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
    }
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
}

- (CLLocationManager*) locationManager {
    if (!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 500;
    }
    return _locationManager;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.mapView.showsUserLocation = YES;
}

- (IBAction)addUserInformation:(id)sender
{
    
}

- (void) viewWillAppear:(BOOL)animated
{
    if (self.police)
    {
        [self.mapView addAnnotations: self.crimeSpotting.items];
    }
    else
    {
        [self.mapView removeAnnotations: self.crimeSpotting.items];
    }
    
    if (self.user)
    {
        [self.mapView addAnnotations: self.userGenerated.items];
    }
    else
    {
        [self.mapView removeAnnotations: self.userGenerated.items];
    }
    
    if (self.twitter)
    {
        
    }
    else
    {
        
    }
    
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    static NSString* reuseID = @"SafetySpectMap";
    MKAnnotationView* view = [mapView dequeueReusableAnnotationViewWithIdentifier: reuseID];
    if (!view)
    {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
        view.canShowCallout = YES;
    }
    return view;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"setSettingsForMap"])
    {
        SafetySpectSettingsViewController* destination = segue.destinationViewController;
        destination.twitter = self.twitter;
        destination.police = self.police;
        destination.user = self.user; 
    }
}

- (IBAction)setSettingsForMap:(id)sender
{
    [self performSegueWithIdentifier:@"setSettingsForMap" sender:self];
}

-(IBAction)returned:(UIStoryboardSegue *)segue
{
    SafetySpectSettingsViewController* destination = segue.sourceViewController;
    self.twitter = destination.twitter;
    self.police = destination.police;
    self.user = destination.user;
}

- (void)mapView:(MKMapView *)MapView didUpdateUserLocation:(MKUserLocation *)UserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    CLLocationCoordinate2D location;
    location.latitude = UserLocation.coordinate.latitude;
    location.longitude = UserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [MapView setRegion:region animated:YES];
}

@end
