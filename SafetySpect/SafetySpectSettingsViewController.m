//
//  SafetySpectSettingsViewController.m
//  SafetySpect
//
//  Created by Akshar Bonu  on 11/2/13.
//  Copyright (c) 2013 Buffalo&Akshar&Mark. All rights reserved.
//

#import "SafetySpectSettingsViewController.h"

@interface SafetySpectSettingsViewController ()

@end

@implementation SafetySpectSettingsViewController

- (void) viewWillAppear:(BOOL)animated
{
    self.policeSwitch.on = self.police;
    self.twitterSwitch.on = self.twitter;
}

- (IBAction)switchChanged:(UISwitch *)sender
{
    if ([sender isEqual: self.policeSwitch])
    {
        self.police = self.policeSwitch.on;
    }
    else if ([sender isEqual: self.twitterSwitch])
    {
        self.twitter = self.twitterSwitch.on;
    }
    else if ([sender isEqual: self.userSwitch])
    {
        self.user = self.userSwitch.on; 
    }
}


@end
