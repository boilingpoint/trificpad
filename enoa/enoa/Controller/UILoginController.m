//
//  UILoginController.m
//  enoa
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 etourer. All rights reserved.
//

#import "UILoginController.h"
#import "ETUser.h"
#import "ETAuthorization.h"
#import "ETColor.h"



#define HELVETICANEUE_FONT(s) [UIFont fontWithName:@"HelveticaNeue" size:s]
#define HELVETICANEUEMEDIUM_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Bold" size:s]
#define HELVETICANEUEBOLD_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Medium" size:s]
#define URL_FINDPASSWORD @"http://tangseng.totalgds.com/retrieve_password/retrieve_password"

@interface UILoginController ()

@end

@implementation UILoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    //self.btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.imgLogo setFrame:CGRectMake(250,
                                  100,
                                  530,
                                  560)];
    [self.txtUserName setFrame:CGRectMake(300,
                                    396,
                                    530,
                                     66)];
    [self.txtPassword setFrame:CGRectMake(300,
                                     462,
                                     530,
                                     66)];
    [self.btnFindPassword setFrame:CGRectMake(self.view.frame.size.width - 300, 40, 150, 50)];
    
    self.btnFindPassword.font = HELVETICANEUE_FONT(14.0f);
    [self.btnFindPassword setTitle:@"Forgot Password" forState:UIControlStateNormal];
    
    self.txtUserName.font = HELVETICANEUE_FONT(30.0f);
    self.txtUserName.placeholder = @"Username";
    self.txtUserName.returnKeyType = UIReturnKeyNext;
    
    self.txtPassword.font = HELVETICANEUE_FONT(30.0f);
    self.txtPassword.placeholder = @"Password";
    self.txtPassword.secureTextEntry = YES;
    self.txtPassword.returnKeyType = UIReturnKeyDone;
    self.txtPassword.delegate = self;
    
    self.btnLogin.font = HELVETICANEUE_FONT(30.0f);
    
    [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
    
    [self.txtUserName addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.txtPassword addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
}


- (IBAction)btnLogin_Click:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Alert" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    BOOL isAlert = false;
    if([self.txtUserName.text isEqualToString:@""])
    {
        [alert setMessage:@"Username can't be empty"];
        isAlert = true;
    }
    else if([self.txtPassword.text isEqualToString:@""])
    {
        [alert setMessage:@"Password can't be empty"];
        isAlert = true;
    }
    if(isAlert)
    {
        [alert show];
        return;
    }
    
    //[super showWithStatus:NSLocalizedString(@"Login_Message", nil)];
    [self.btnLogin setTitle:@"Loging..." forState:UIControlStateSelected];
    const char *queueName = [[[NSDate date] description] UTF8String];
    dispatch_queue_t myQueue = dispatch_queue_create(queueName, NULL);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(myQueue, ^{
        ETUser *user = [ETUser alloc];
        [user init];
        dispatch_async(mainQueue, ^{
            [super dismiss];
            if(user == nil || user.error != nil)
            {
                [alert show];
                
            } else {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:user.access_token forKey:@"token"];
                [userDefaults setObject:user.merchant_code forKey:@"merchant"];
                [userDefaults setObject:self.txtUserName.text forKey:@"user_name"];
                [userDefaults setObject:user.expire_in forKey:@"expired"];
                
                [self gotoView:[self.storyboard instantiateViewControllerWithIdentifier:@"UIHome"]];
            
             }
        });
    });
             
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 66 - (self.view.frame.size.height - 380);//键盘高度380
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (IBAction)btnFindPassword_TouchUpInside:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_FINDPASSWORD]];
}

-(void)resumeView
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    float Y = 20.0f;
    CGRect rect = CGRectMake(0.0f, Y, width, height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

-(void)hideKeyboard
{
    [self.txtUserName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self resumeView];
}

-(IBAction)nextOnKeyboard:(UITextField *)sender
{
    if(sender == self.txtUserName)
    {
        [self.txtPassword becomeFirstResponder];
    }
    else if(sender == self.txtPassword)
    {
        [self hideKeyboard];
    }
}

@end