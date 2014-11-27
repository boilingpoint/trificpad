//
//  UIBaseController.m
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "UIBaseController.h"
#import "ETNetworkHelper.h"
#import "ETProgressHUD.h"
#import "ETColor.h"
#import "UINotificationController.h"


@interface UIBaseController ()

@end


@implementation UIBaseController


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.view.backgroundColor = [ETColor colorWithHexString:@"#f6f6f6" ];
}


-(void)gotoView:(UIViewController *)viewController
{
    int flag = 0;
    
    for(UIViewController *controller in self.navigationController.viewControllers)
    {
        if([controller isKindOfClass:[viewController class]])
        {
            flag = 1;
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    if(flag == 0)
    {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


-(void) toolbarChange:(NSInteger)  tag BackTo:(NSString *) backTo
{
    //UINotificationController *notifiController = nil;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit Alert" message:@"Do you want to exit" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    switch(tag)
    {
        case 1:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UITransportation"]];
            break;
        case 2:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UICheckin"]];
            break;
        case 3:
            break;
        case 4:
            //notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
            [self gotoView: [self.storyboard instantiateViewControllerWithIdentifier:@"UINotification"]];
            break;
        case 5:
            [alert show];
            break;
        case 6:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:backTo]];
            break;
        default:
            [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UIHome"]];
            break;
    }
}

- (void)handleNotification:(NSNotification *)notif
{
    NSLog(@"Notification recieved: %@", notif.name);
    NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:ETProgressHUDStatusUserInfoKey]);
}

#pragma mark -
#pragma mark Show Methods Sample

- (void)show {
    [ETProgressHUD show];
}

- (void)showWithStatus:(NSString *)message {
    if(message == nil)
    {
        message = @"Doing Stuff";
    }
    [ETProgressHUD showWithStatus:message];
}

static float progress = 0.0f;

- (IBAction)showWithProgress:(id)sender {
    progress = 0.0f;
    [ETProgressHUD showProgress:0 status:@"Loading"];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3];
}

- (void)increaseProgress:(NSString *)message {
    if(message == nil)
    {
        message = @"Loading!";
    }
    progress+=0.1f;
    [ETProgressHUD showProgress:progress status:message];
    
    if(progress < 1.0f)
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3];
    else
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}

-(id)GetObjectByKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

-(void)SetObject:(id)object ByKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
}

#pragma mark -
#pragma mark Dismiss Methods Sample

- (void)dismiss {
    [ETProgressHUD dismiss];
}

- (void)dismissSuccess:(NSString *)message {
    if(message == nil)
    {
        message = @"Great Success!";
    }
    [ETProgressHUD showSuccessWithStatus:message];
}

- (void)dismissError:(NSString *)message {
    if(message == nil)
    {
        message = @"Failed with Error";
    }
    [ETProgressHUD showErrorWithStatus:message];
}

#pragma font

-(UIFont *)HELVETICANEUE_FONT:(NSInteger)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

-(UIFont *)HELVETICANEUEMEDIUM_FONT:(NSInteger)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

-(UIFont *)HELVETICANEUEBOLD_FONT:(NSInteger)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

@end