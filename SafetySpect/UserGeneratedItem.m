//
//  UserGeneratedItem.m
//  SafetySpect
//
//  Created by Akshar Bonu  on 11/2/13.
//  Copyright (c) 2013 Buffalo&Akshar&Mark. All rights reserved.
//

#import "UserGeneratedItem.h"

@implementation UserGeneratedItem

-(void)initFromParseObject:(PFObject *) parseObject;
{
    self.createdAt = parseObject.createdAt;
    self.updatedAt = parseObject.updatedAt;
    self.title = [parseObject objectForKey: @"title"];
    self.subtitle = [parseObject objectForKey: @"subtitle"];
    self.type = [parseObject objectForKey: @"type"];
    self.date = [parseObject objectForKey: @"date"];
    self.latitude = [[parseObject objectForKey: @"latitude"] doubleValue];
    self.longitude = [[parseObject objectForKey: @"longitude"] doubleValue];
}

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

@end
