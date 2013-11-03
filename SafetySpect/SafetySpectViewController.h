//
//  SafetySpectViewController.h
//  SafetySpect
//
//  Created by Akshar Bonu  on 11/2/13.
//  Copyright (c) 2013 Buffalo&Akshar&Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CrimeSpotting.h"
#import "UserGenerated.h"

@interface SafetySpectViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet MKMapView* mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic) BOOL police;
@property (nonatomic) BOOL twitter;
@property (nonatomic) BOOL user;

@property (nonatomic, strong) CrimeSpotting* crimeSpotting;
@property (nonatomic, strong) UserGenerated* userGenerated;

@end
