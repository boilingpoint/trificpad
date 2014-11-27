//
//  UITransLocationController.h
//  enoa
//
//  Created by admin on 14-11-27.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_UITransLocationController_h
#define enoa_UITransLocationController_h

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIBaseController.h"
#import "ETRPLine.h"

@interface UITransLocationController : UIBaseController<UITableViewDelegate, UITableViewDataSource>{
}

@property(nonatomic, weak)ETRPLine *line;
@property NSArray *transLocations;

@property (strong, nonatomic) IBOutlet UIToolbar *tabNav;
@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)toolBarItemTap:(id)sender;
@end

#endif
