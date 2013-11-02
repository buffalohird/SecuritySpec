//
//  CrimeSpottingItem.h
//  PublicSafety
//
//  Created by Buffalo Hird on 11/2/13.
//  Copyright (c) 2013 Buffalo Hird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CrimeSpottingItem : NSObject <MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString* title;
@property (nonatomic, readonly, copy) NSString* subtitle;

@property (nonatomic) int itemId;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSString* titleRead;
@property (nonatomic, strong) NSString* subtitleRead;

@property (nonatomic, strong) NSDictionary* dictionary; 

-(void)initFromDictionary:(NSDictionary *)dictionary;
-(void)printItem;
-(CLLocationCoordinate2D)coordinate;


@end
