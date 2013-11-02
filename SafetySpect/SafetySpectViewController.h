//
//  SafetySpectViewController.h
//  SafetySpect
//
//  Created by Akshar Bonu  on 11/2/13.
//  Copyright (c) 2013 Buffalo&Akshar&Mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrimeSpotting.h"
#import <MapKit/MapKit.h>

@interface SafetySpectViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView* mapView;
@property (nonatomic, strong) CrimeSpotting* crimeSpotting;

@end
