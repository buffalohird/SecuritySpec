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
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleGesture:)];
    longPress.delegate = self;
    longPress.minimumPressDuration = 2.0;  //user must press for 2 seconds
    
    [self.mapView addGestureRecognizer:longPress];
    
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
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView: self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView: self.mapView];
    
    self.coordSubmit = touchMapCoordinate;
    [self performSegueWithIdentifier:@"submitCrime" sender:self];

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
    self.coordSubmit = self.mapView.userLocation.coordinate;
    [self performSegueWithIdentifier:@"submitCrime" sender:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.mapView removeAnnotations: self.mapView.annotations];
    
    [self.crimeSpotting getDataFromUrl:@"http://sanfrancisco.crimespotting.org/crime-data?format=json&count=1000"];
    [self.userGenerated getDataForParseObject: @"UserCrimeAnnotation"];
    
    if (self.police)
    {
        [self.mapView addAnnotations: self.crimeSpotting.items];
    }
    
    if (self.user)
    {
        [self.mapView addAnnotations: self.userGenerated.items];
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
    MKPinAnnotationView* view = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: reuseID];
    if (!view)
    {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
        view.canShowCallout = YES;
        if ([self.crimeSpotting.items containsObject: annotation])
        {
            view.pinColor = MKPinAnnotationColorRed;
        }
        else if ([self.userGenerated.items containsObject: annotation])
        {
            view.pinColor = MKPinAnnotationColorGreen;
        }
        if ([mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
            view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        view.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,30,30)];
    }
    return view;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)(view.leftCalloutAccessoryView);
        if ([view.annotation respondsToSelector:@selector(thumbnail)]) {
            // this should be done in a different thread!
            imageView.image = [view.annotation performSelector:@selector(thumbnail)];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"setSettingsForMap"])
    {
        SafetySpectSettingsViewController* destination = segue.destinationViewController;
        destination.twitter = self.twitter;
        destination.police = self.police;
        destination.user = self.user; 
    }
    else if ([segue.identifier isEqualToString:@"submitCrime"])
    {
        
        SafetySpectSubmitViewController* destination = segue.destinationViewController;
        destination.coordinate = self.coordSubmit;
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
