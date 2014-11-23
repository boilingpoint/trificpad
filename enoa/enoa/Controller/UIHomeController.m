//
//  UIHomeController.m
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "UIHomeController.h"
#import "ETColor.h"
#import "UINotificationController.h"


@interface UIHomeController ()

@end


#define NAV_HEIGHT 60.0f
#define NAV_X 0
#define NAV_Y 20
#define NAV_BG @"#106bf8"


@implementation UIHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    

    //[super.navigationController setNavigationBarHidden:1 animated:true];
    /*
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, 1024, 44)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    //在这个集合Item中添加标题，按钮
    //style:设置按钮的风格，一共有三种选择
    //action：@selector:设置按钮的点击事件
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStyleBordered target:self action:@selector(clickLeftButton)];
    ////创建一个右边按钮
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightButton)];
    
    //设置导航栏的内容
    [navItem setTitle:@"凌凌漆"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:leftButton];
    //[navItem setRightBarButtonItem:rightButton];
    
    
    
    //将标题栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];*/
    //[self.view addSubview:transButton];
    //[self.view addSubview:checkInButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMap_Click:(id)sender {
    
    [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UIMap"]];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //self.transButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.checkinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.tabNav setFrame:CGRectMake(NAV_X, NAV_Y, self.view.frame.size.width, NAV_HEIGHT)];
    [self.tabNav setBackgroundColor:[ETColor colorWithHexString:NAV_BG]];
    

    [self.transButton setFrame:CGRectMake(191,
                                         298,
                                         257,
                                         257)];
    self.transButton.backgroundColor = [ETColor colorWithHexString:@"#ffffff" ];
    [self.transButton setBackgroundImage:[UIImage imageNamed:@"home_transportation.png"] forState:UIControlStateNormal];
    [self.transButton setBackgroundImage:[UIImage imageNamed:@"home_transportation_current.png"] forState:UIControlStateHighlighted];
    [self.transButton setTitle:@"" forState:UIControlStateNormal];
    
    
    [self.checkinButton setFrame:CGRectMake(575,
                                         298,
                                         257,
                                         257)];
    
    [self.checkinButton setBackgroundImage:[UIImage imageNamed:@"home_checkin.png"] forState:UIControlStateNormal];
    [self.checkinButton setBackgroundImage:[UIImage imageNamed:@"home_checkin_current.png"] forState:UIControlStateHighlighted];
    
    self.checkinButton.backgroundColor = [ETColor colorWithHexString:@"#ffffff" ];
    [self.checkinButton setTitle:@"" forState:UIControlStateNormal];
    
    [self.view addSubview:self.transButton];
    [self.view addSubview:self.checkinButton];
}
- (IBAction)transButton_TouchUpInside:(id)sender {
    [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UITransportation"]];
}

- (IBAction)checkinButton_TouchUpInside:(id)sender {
    [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UICheckin"]];
}

- (IBAction)toolBarItemTap:(id)sender {
    NSInteger tag = [sender tag];
    //UINotificationController *notifiController = nil;
    //notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
    [super toolbarChange:tag BackTo:@""];
    /*
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
            notifiController = [[UINotificationController alloc] initWithStyle:UITableViewStylePlain];
            [self gotoView: notifiController];
            break;
        case 5:
            [alert show];
            break;
        default:
            break;
    }
     */
}




-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        return;
    }
    else if(buttonIndex == 1)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"token"];
        [userDefaults removeObjectForKey:@"merchant"];
        [userDefaults removeObjectForKey:@"expired"];
        
        [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UILogin"]];
        //[self performSegueWithIdentifier:@"loginPage" sender:self];
    }
}
@end
