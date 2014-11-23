//
//  UINotificationController.h
//  enoa
//
//  Created by admin on 14-11-15.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIBaseController.h"
#import "SWTableViewCell.h"
//#import "ETButton.h"

@interface UINotificationController : UIBaseController<UITableViewDelegate,UITableViewDataSource, SWTableViewCellDelegate>{
}
//@property (strong, nonatomic) IBOutlet UIToolbar *tabNav;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *toolbarView;

- (IBAction)toolBarItemTap:(id)sender;

@end
