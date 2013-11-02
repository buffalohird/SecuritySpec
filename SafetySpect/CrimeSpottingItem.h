//
//  CrimeSpottingItem.h
//  PublicSafety
//
//  Created by Buffalo Hird on 11/2/13.
//  Copyright (c) 2013 Buffalo Hird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CrimeSpottingItem : NSObject

@property (nonatomic) int itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSDictionary *dict;

-(void)initFromDictionary:(NSDictionary *)dictionary;
-(void)printItem;


@end
