//
//  UIBaseController.h
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "ETNetworkHelper.h"

@interface UIBaseController : UIViewController
- (IBAction)goto:(id)sender;

-(id)GetObjectByKey:(NSString *)key;
-(void)SetObject:(id)object ByKey:(NSString *)key;
-(id)GetObjectByKey:(NSString *)key;
-(void)gotoView:(UIViewController *)viewController;

-(void) toolbarChange:(NSInteger) tag BackTo:(NSString *) backTo;


- (IBAction)show;
- (IBAction)showWithStatus:(NSString *)message;

- (IBAction)dismiss;
- (IBAction)dismissSuccess:(NSString *)message;
- (IBAction)dismissError:(NSString *)message;

-(bool)isNetworkConnected;
-(void)SetObject:(id)object ByKey:(NSString *)key;
@end