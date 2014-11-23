//
//  TestController.h
//  enoa
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_UITransportationDetailController_h
#define enoa_UITransportationDetailController_h


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIBaseController.h"

@interface UITransportationDetailController : UIBaseController<UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>{
}

@property (strong, nonatomic) IBOutlet UIToolbar *tabNav;
@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)toolBarItemTap:(id)sender;
@end

#endif
