//
//  UICheckinDetailController.h
//  enoa
//
//  Created by admin on 14-11-20.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#ifndef enoa_UICheckinDetailController_h
#define enoa_UICheckinDetailController_h

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIBaseController.h"

@interface UICheckinDetailController : UIBaseController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_array;
    NSMutableArray *_CurrentArray;
}

@property (strong, nonatomic) IBOutlet UIToolbar *tabNav;
@property (strong, nonatomic) IBOutlet UIView *controlView;
@property (strong, nonatomic) IBOutlet UILabel *lblInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblInventory;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)toolBarItemTap:(id)sender;
@end

#endif
