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

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

-(void)initFromDictionary:(NSDictionary *)dictionary
{
    //for(id key in dictionary)
      //  NSLog(@"key=%@ value=%@", key, [dictionary objectForKey:key]);
    
    self.itemId = [dictionary[@"id"] intValue];
    self.title = dictionary[@"properties"][@"crime_type"];
    self.title = [[[self.title substringToIndex:1] uppercaseString] stringByAppendingString:[[self.title substringFromIndex:1] lowercaseString]];
    self.time = dictionary[@"properties"][@"date_time"];
    self.subtitle = dictionary[@"properties"][@"description"];
    self.subtitle = [[[self.subtitle substringToIndex:1] uppercaseString] stringByAppendingString:[[self.subtitle substringFromIndex:1] lowercaseString]];
    self.longitude = [dictionary[@"geometry"][@"coordinates"][0] doubleValue];
    self.latitude = [dictionary[@"geometry"][@"coordinates"][1] doubleValue];
    self.type = @"police"; 
    
}


@end
