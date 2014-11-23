//
//  UIMapController.m
//  enoa
//
//  Created by admin on 14-10-23.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import "UIMapController.h"

@interface UIMapController ()

@end

@implementation UIMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)findMe:(id)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    [self.locationManager startUpdatingLocation];
    [_activity startAnimating];
    NSLog(@"start gps");
}
-(IBAction)webMap:(id)sender; {
    //
}

@end
