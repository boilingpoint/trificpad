//
//  UIHomeController.h
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseController.h"


@interface UIHomeController : UIBaseController

@property (strong, nonatomic) IBOutlet UIButton *transButton;

@property (strong, nonatomic) IBOutlet UIButton *checkinButton;
@property (strong, nonatomic) IBOutlet UIToolbar *tabNav;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *homeButtonItem;

- (IBAction)transButton_TouchUpInside:(id)sender;
- (IBAction)checkinButton_TouchUpInside:(id)sender;
- (IBAction)toolBarItemTap:(id)sender;

@end

