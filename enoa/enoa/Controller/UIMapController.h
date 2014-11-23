//
//  UIMapController.h
//  enoa
//
//  Created by admin on 14-10-23.
//  Copyright (c) 2014年 etourer. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIBaseController.h"

@interface UIMapController : UIBaseController<UINavigationControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (retain, nonatomic) IBOutlet UILabel *longitudeText;
@property (retain, nonatomic) IBOutlet UILabel *latitudeText;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activity;

-(IBAction)findMe:(id)sender;
-(IBAction)webMap:(id)sender;

@end
