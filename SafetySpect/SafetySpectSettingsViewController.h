//
//  SafetySpectSettingsViewController.h
//  SafetySpect
//
//  Created by Akshar Bonu  on 11/2/13.
//  Copyright (c) 2013 Buffalo&Akshar&Mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafetySpectSettingsViewController : UIViewController

@property (nonatomic) BOOL police;
@property (nonatomic) BOOL twitter;
@property (nonatomic) BOOL user;

@property (weak, nonatomic) IBOutlet UISwitch *policeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *twitterSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *userSwitch;

@end
