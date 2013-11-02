//
//  SafetySpectViewController.m
//  SafetySpect
//
//  Created by Akshar Bonu  on 11/2/13.
//  Copyright (c) 2013 Buffalo&Akshar&Mark. All rights reserved.
//

#import "SafetySpectViewController.h"

@interface SafetySpectViewController ()

@end

@implementation SafetySpectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    CrimeSpotting* crimeSpotting = [[CrimeSpotting alloc] init];
    [crimeSpotting getDataFromUrl:@"http://sanfrancisco.crimespotting.org/crime-data?format=json&count=10"];
    [self.mapView addAnnotations: crimeSpotting.items];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString* reuseID = @"SafetySpectMap";
    MKAnnotationView* view = [mapView dequeueReusableAnnotationViewWithIdentifier: reuseID];
    if (!view)
    {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
        view.canShowCallout = YES;
    }
    return view;
}


@end
