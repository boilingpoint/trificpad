//
//  UILoginController.h
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIBaseController.h"
//#import "ETButton.h"

@interface UILoginController : UIBaseController
{
    float move;
}

@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;


@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnFindPassword;

@property (strong, nonatomic) IBOutlet UIView *vContent;

- (IBAction)textFieldDidBeginEditing:(id)sender;

- (IBAction)textFieldDidEndEditing:(id)sender;
- (IBAction)btnFindPassword_TouchUpInside:(id)sender;


- (IBAction)btnLogin_Click:(id)sender;

@end
