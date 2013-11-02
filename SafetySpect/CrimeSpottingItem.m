//
//  CrimeSpottingItem.m
//  PublicSafety
//
//  Created by Buffalo Hird on 11/2/13.
//  Copyright (c) 2013 Buffalo Hird. All rights reserved.
//

#import "CrimeSpottingItem.h"

@implementation CrimeSpottingItem

@synthesize itemId = _itemId;

-(void)initFromDictionary:(NSDictionary *)dictionary
{
    //for(id key in dictionary)
      //  NSLog(@"key=%@ value=%@", key, [dictionary objectForKey:key]);
    
    self.itemId = [dictionary[@"id"] intValue];
    self.title = dictionary[@"properties"][@"crime_type"];
    self.time = dictionary[@"properties"][@"date_time"];
    self.subtitle = dictionary[@"properties"][@"description"];
    
    self.latitude = [dictionary[@"geometry"][@"coordinates"][0] floatValue];
    self.longitude = [dictionary[@"geometry"][@"coordinates"][1] floatValue];
    
}

-(void)printItem
{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:
                          [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", self.itemId],
                                                    self.title,
                                                    self.time,
                                                    self.subtitle,
                                                    [NSString stringWithFormat:@"%f", self.latitude],
                                                    [NSString stringWithFormat:@"%f", self.longitude],
                                                    nil]

                                                        forKeys:
                          [NSArray arrayWithObjects:@"id", @"title", @"time", @"subtitle", @"latitude", @"longitude", nil]];
    
    NSLog([NSString stringWithFormat:@"%@", dict]);
}

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
    
}

@end
